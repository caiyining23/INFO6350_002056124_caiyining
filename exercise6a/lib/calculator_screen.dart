import 'package:flutter/material.dart';
import 'calculator_logic.dart';
import 'button_widget.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic _calculator = CalculatorLogic();

  void _onButtonPressed(String value) {
    setState(() {
      _calculator.processInput(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Calculator", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          /// Calculation Process Display
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              _calculator.process,
              style: TextStyle(fontSize: 28, color: Colors.grey),
            ),
          ),

          /// Result Display
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              _calculator.output,
              style: TextStyle(fontSize: 52, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),

          Divider(color: Colors.white54),

          /// Buttons Layout with increased spacing
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButtonRow(["7", "8", "9", "÷"]),
                _buildButtonRow(["4", "5", "6", "×"]),
                _buildButtonRow(["1", "2", "3", "-"]),
                _buildButtonRow(["C", "0", "=", "+"]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build a row of buttons with more spacing
  Widget _buildButtonRow(List<String> values) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: values.map((text) => _buildButton(text)).toList(),
      ),
    );
  }

  /// Build a single button
  Widget _buildButton(String text) {
    return CalculatorButton(text: text, onPressed: () => _onButtonPressed(text));
  }
}
