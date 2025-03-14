import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CalculatorButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool isOperator = ["+", "-", "×", "÷", "="].contains(text);
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),  // Add spacing
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: isOperator ? Colors.white : Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 24),  // Increase button height
            backgroundColor: isOperator ? Colors.orange : Colors.grey[300],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Slightly rounded corners
          ),
        ),
      ),
    );
  }
}
