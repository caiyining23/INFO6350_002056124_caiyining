import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'guest_book_message.dart';

// Enum for attendance status
enum Attending { yes, no, unknown }

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  // Firebase Auth state
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  bool _emailVerified = false;
  bool get emailVerified => _emailVerified;

  // Guestbook messages
  List<GuestBookMessage> _guestBookMessages = [];
  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;
  StreamSubscription<QuerySnapshot>? _guestBookSubscription;

  // Attendee count
  int _attendees = 0;
  int get attendees => _attendees;

  // User attendance status
  Attending _attending = Attending.unknown;
  Attending get attending => _attending;
  StreamSubscription<DocumentSnapshot>? _attendingSubscription;

  // Set attendance and update Firestore
  set attending(Attending attending) {
    final userDoc = FirebaseFirestore.instance
        .collection('attendees')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    if (attending == Attending.yes) {
      userDoc.set({'attending': true});
    } else {
      userDoc.set({'attending': false});
    }
  }

  // Firebase initialization and listeners
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    // Track total number of attendees
    FirebaseFirestore.instance
        .collection('attendees')
        .where('attending', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _attendees = snapshot.docs.length;
      notifyListeners();
    });

    // Track user auth state
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _emailVerified = user.emailVerified;

        // Listen to guestbook
        _guestBookSubscription = FirebaseFirestore.instance
            .collection('guestbook')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _guestBookMessages = snapshot.docs.map((doc) {
            final data = doc.data();
            return GuestBookMessage(
              name: data['name'] as String,
              message: data['text'] as String,
            );
          }).toList();
          notifyListeners();
        });

        // Listen to this user's attending status
        _attendingSubscription = FirebaseFirestore.instance
            .collection('attendees')
            .doc(user.uid)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.data() != null) {
            final isAttending = snapshot.data()!['attending'] as bool;
            _attending = isAttending ? Attending.yes : Attending.no;
          } else {
            _attending = Attending.unknown;
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _emailVerified = false;
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
        _attendingSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  // Add new message to guestbook
  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance.collection('guestbook').add({
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }
}
