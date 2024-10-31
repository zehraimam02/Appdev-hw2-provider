import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalculatorProvider extends ChangeNotifier{

  String _displayText= '0';
  String _calculationHistory = '';

  String get displayText => _displayText;
  String get calculationHistory => _calculationHistory;

  void setValue(String value) {
    if(_displayText == "0" && value != "="){
      _displayText = value;
    }else {
      switch (value) {
        case "AC":
          _displayText = "0";
          _calculationHistory = '';
          break;
        case "+/-":
          toggleSign();
          break;
        case "%":
          applyPercentage();
          break;
        case '×':
          _displayText += "*";
          break;
        case "=":
          calculate();
          break;
        default:
          _displayText += value;
      }
    }
    notifyListeners();
  }

  // Method to toggle the sign of the current display value
  void toggleSign() {
    if(_displayText.isNotEmpty) {
      if (_displayText.startsWith('-')) {
        _displayText = _displayText.substring(1);
      } else if (_displayText != 0) {
        _displayText = '-' + _displayText;
      }
    }
  }

  //  Method to apply percentage 
  void applyPercentage() {
    try {
      num currentNumber = _displayText.interpret();
      _displayText = (currentNumber / 100).toString();
    } catch (e) {
      _displayText = "Error";
    }
  }

  // Method to perform arithematic operations
  void calculate(){
    try {
      String expression = _displayText.replaceAll("×", "*");
      expression = _displayText.replaceAll("÷", "/");
      num result = expression.interpret();

      _calculationHistory = _displayText;
      _displayText = result == result.toInt()
        ? result.toInt().toString()
        : result.toString();
    } catch(e) {
      _displayText = "Error";
    }
    notifyListeners();
  }
}