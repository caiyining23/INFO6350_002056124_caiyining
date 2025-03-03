import 'package:flutter/material.dart';
import 'hero_animation.dart';
import 'radial_hero_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Animations',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HeroAnimationsHomePage(),
    );
  }
}

class HeroAnimationsHomePage extends StatelessWidget {
  const HeroAnimationsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Animations Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HeroAnimation()),
                );
              },
              child: const Text('Standard Hero Animation'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RadialHeroAnimation()),
                );
              },
              child: const Text('Radial Hero Animation'),
            ),
          ],
        ),
      ),
    );
  }
}
