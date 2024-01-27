import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = "0";

  void onButtonPressed(String value) {
    setState(() {
      if (displayText == "0") {
        displayText = value;
      } else {
        displayText += value;
      }
    });
  }

  bool _endsWithOperator() {
    return RegExp(r'[+\-×÷]$').hasMatch(displayText);
  }

  void onOperatorPressed(String operator) {
    setState(() {
      if (displayText != "0") {
        if (_endsWithOperator()) {
          displayText =
              displayText.substring(0, displayText.length - 1) + operator;
        } else {
          displayText += operator;
        }
      }
    });
  }

  void onEqualPressed() {
    setState(() {
      displayText = "0";
    });
  }

  void onClearPressed() {
    setState(() {
      displayText = "0";
    });
  }

  void onBackspacePressed() {
    setState(() {
      if (displayText.length > 1) {
        displayText = displayText.substring(0, displayText.length - 1);
      } else {
        displayText = "0";
      }
    });
  }

  Widget buildButton(String value) {
    return Expanded(
      child: InkWell(
        onTap: () => onButtonPressed(value),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: 70.0,
            height: 70.0,
            color: Color.fromARGB(255, 164, 241, 186),
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Text(
              value,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCalculatorOperatorButton(dynamic value, {VoidCallback? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: 70.0,
            height: 70.0,
            color: value == "="
                ? const Color.fromARGB(255, 47, 167, 51)
                : Color.fromARGB(255, 207, 207, 207),
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (value is Icon)
                  value
                else
                  Text(
                    value,
                    style: TextStyle(
                        fontSize: 24.0,
                        color: value == "="
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : const Color.fromARGB(255, 3, 3, 3)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                displayText,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Row(
            children: [
              buildCalculatorOperatorButton("C", onTap: onClearPressed),
              buildCalculatorOperatorButton(Icon(Icons.backspace),
                  onTap: onBackspacePressed),
            ],
          ),
          Row(
            children: [
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildCalculatorOperatorButton("÷",
                  onTap: () => onOperatorPressed("÷")),
            ],
          ),
          Row(
            children: [
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildCalculatorOperatorButton("×",
                  onTap: () => onOperatorPressed("×")),
            ],
          ),
          Row(
            children: [
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildCalculatorOperatorButton("-",
                  onTap: () => onOperatorPressed("-")),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: buildButton("0"),
                ),
              ),
              buildCalculatorOperatorButton("+",
                  onTap: () => onOperatorPressed("+")),
            ],
          ),
          Row(
            children: [
              buildCalculatorOperatorButton("=", onTap: () => onEqualPressed()),
            ],
          ),
        ],
      ),
    );
  }
}
