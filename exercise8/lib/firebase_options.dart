// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDCY8Pbar6C7IhOHS61MoNMIb2Y04OqNQo',
    appId: '1:20018553923:web:8ac0bb6b006ebfa6fd20f6',
    messagingSenderId: '20018553923',
    projectId: 'exercise8-29209',
    authDomain: 'exercise8-29209.firebaseapp.com',
    storageBucket: 'exercise8-29209.firebasestorage.app',
    measurementId: 'G-0VMM7SSEYB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYI2Ue9xYSDFYUDcH7XUA24SWGKrJtqho',
    appId: '1:20018553923:android:9a7ef8f8d685d00ffd20f6',
    messagingSenderId: '20018553923',
    projectId: 'exercise8-29209',
    storageBucket: 'exercise8-29209.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDCfHbuhAYuoVth1sjKkTn1eBkPFj10PFw',
    appId: '1:20018553923:ios:711368168784c9f4fd20f6',
    messagingSenderId: '20018553923',
    projectId: 'exercise8-29209',
    storageBucket: 'exercise8-29209.firebasestorage.app',
    iosBundleId: 'com.example.exercise8',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDCfHbuhAYuoVth1sjKkTn1eBkPFj10PFw',
    appId: '1:20018553923:ios:711368168784c9f4fd20f6',
    messagingSenderId: '20018553923',
    projectId: 'exercise8-29209',
    storageBucket: 'exercise8-29209.firebasestorage.app',
    iosBundleId: 'com.example.exercise8',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDCY8Pbar6C7IhOHS61MoNMIb2Y04OqNQo',
    appId: '1:20018553923:web:de93934a276d9eaafd20f6',
    messagingSenderId: '20018553923',
    projectId: 'exercise8-29209',
    authDomain: 'exercise8-29209.firebaseapp.com',
    storageBucket: 'exercise8-29209.firebasestorage.app',
    measurementId: 'G-8X47YX7W7E',
  );
}
