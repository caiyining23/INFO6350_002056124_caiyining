class Question {
  final String questionText;
  final List<Map<String, dynamic>> options;
  final String type;

  Question({required this.questionText, required this.options, required this.type});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['question'],
      options: List<Map<String, dynamic>>.from(json['options']),
      type: json['type'],
    );
  }
}
