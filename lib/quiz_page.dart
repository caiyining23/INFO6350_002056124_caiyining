import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'question_model.dart';
import 'score_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  int timeLeft = 60;
  Timer? timer;
  Set<String> selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    loadQuestions();
    startTimer();
  }

  // Load questions from the assets JSON file
  void loadQuestions() async {
    String data = await DefaultAssetBundle.of(context).loadString('assets/questions.json');
    final List<dynamic> loadedData = json.decode(data);
    setState(() {
      questions = loadedData.map((item) => Question.fromJson(item)).toList();
      questions.shuffle();
    });
  }

  // Start the 60-second timer
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          completeQuiz();
        }
      });
    });
  }

  // Evaluate multiple choice answers
  void answerMultipleChoice() {
    var correctOptions = questions[currentQuestionIndex]
        .options
        .where((option) => option['correct'])
        .map((option) => option['text'])
        .toSet();

    if (selectedAnswers.containsAll(correctOptions) &&
        correctOptions.containsAll(selectedAnswers)) {
      score++;
    }

    selectedAnswers.clear();
    nextQuestion();
  }

  // Evaluate single choice or true/false answers
  void answerSingleChoice(bool correct) {
    if (correct) {
      score++;
    }
    nextQuestion();
  }

  // Move to the next question
  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswers.clear();
      });
    } else {
      completeQuiz();
    }
  }

  // Complete the quiz and navigate to the score page
  void completeQuiz() {
    timer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScorePage(
          score: score,
          total: questions.length,
          timedOut: timeLeft == 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Time left: $timeLeft sec', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text(question.questionText, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),

            // Multiple choice questions
            if (question.type == 'multiple') ...[
              ...question.options.map((option) {
                return CheckboxListTile(
                  title: Text(option['text']),
                  value: selectedAnswers.contains(option['text']),
                  onChanged: (bool? selected) {
                    setState(() {
                      if (selected == true) {
                        selectedAnswers.add(option['text']);
                      } else {
                        selectedAnswers.remove(option['text']);
                      }
                    });
                  },
                );
              }).toList(),
              ElevatedButton(
                onPressed: () => answerMultipleChoice(),
                child: const Text('Submit Answer'),
              )
            ],

            // Single choice and true/false questions
            if (question.type == 'single' || question.type == 'true_false') ...[
              ...question.options.map((option) {
                return ElevatedButton(
                  onPressed: () => answerSingleChoice(option['correct']),
                  child: Text(option['text']),
                );
              }).toList(),
            ]
          ],
        ),
      ),
    );
  }
}
