import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int total;
  final bool timedOut;

  const ScorePage({Key? key, required this.score, required this.total, required this.timedOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Completed')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timedOut ? 'Time is up! No score.' : 'Your score: $score/$total',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
