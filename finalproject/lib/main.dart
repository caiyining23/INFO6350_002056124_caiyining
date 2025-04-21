import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'browse_posts_activity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HyperGarageSaleApp());
}

class HyperGarageSaleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HyperGarageSale',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BrowsePostsActivity(),
      debugShowCheckedModeBanner: false,
    );
  }
}
