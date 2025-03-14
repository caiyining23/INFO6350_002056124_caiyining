class CalculatorLogic {
  String _output = "0";   // Final result
  String _process = "";   // Calculation process
  String _currentInput = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";

  String get output => _output;
  String get process => _process; // Expose process string

  void processInput(String value) {
    if (value == "C") {
      _clear();
    } else if (value == "+" || value == "-" || value == "×" || value == "÷") {
      _setOperator(value);
    } else if (value == "=") {
      _calculateResult();
    } else {
      _appendNumber(value);
    }
  }

  void _clear() {
    _output = "0";
    _process = "";
    _currentInput = "";
    _num1 = 0;
    _num2 = 0;
    _operator = "";
  }

  void _setOperator(String operator) {
    if (_currentInput.isNotEmpty) {
      _num1 = double.parse(_currentInput);
      _operator = operator;
      _process = "$_num1 $_operator"; // Show process
      _currentInput = "";
    }
  }

  void _calculateResult() {
    if (_currentInput.isNotEmpty && _operator.isNotEmpty) {
      _num2 = double.parse(_currentInput);
      switch (_operator) {
        case "+":
          _output = (_num1 + _num2).toString();
          break;
        case "-":
          _output = (_num1 - _num2).toString();
          break;
        case "×":
          _output = (_num1 * _num2).toString();
          break;
        case "÷":
          _output = _num2 != 0 ? (_num1 / _num2).toString() : "Error";
          break;
      }
      _process = "$_num1 $_operator $_num2 = $_output"; // Update process
      _currentInput = _output;
      _operator = "";
    }
  }

  void _appendNumber(String number) {
    if (_output == "0" || _output == "Error") {
      _output = number;
    } else {
      _output += number;
    }
    _currentInput += number;
  }
}
