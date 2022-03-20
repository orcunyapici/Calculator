import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 48.0;
  double resultFontSize = 38.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "←") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('%', '/');

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else
          equation = equation + buttonText;
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
      Color textColor) {
    return Container(
      margin: EdgeInsets.all(1),
      height: MediaQuery.of(context).size.height * 0.12 * buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(color: textColor, fontSize: 30),
        ),
        onPressed: () {
          buttonPressed(buttonText);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 80, 10, 0),
            child: Text(equation,
                style:
                    TextStyle(fontSize: equationFontSize, color: Colors.white)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
            child: Text(result,
                style:
                    TextStyle(fontSize: resultFontSize, color: Colors.white)),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.grey, Colors.black),
                        buildButton("←", 1, Colors.grey, Colors.black),
                        buildButton("%", 1, Colors.orange[400], Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.grey[800], Colors.white),
                        buildButton("8", 1, Colors.grey[800], Colors.white),
                        buildButton("9", 1, Colors.grey[800], Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.grey[800], Colors.white),
                        buildButton("5", 1, Colors.grey[800], Colors.white),
                        buildButton("6", 1, Colors.grey[800], Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.grey[800], Colors.white),
                        buildButton("2", 1, Colors.grey[800], Colors.white),
                        buildButton("3", 1, Colors.grey[800], Colors.white),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.grey[800], Colors.white),
                        buildButton("0", 1, Colors.grey[800], Colors.white),
                        buildButton("00", 1, Colors.grey[800], Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("x", 1, Colors.orange[400], Colors.white),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.orange[400], Colors.white),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.orange[400], Colors.white),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.orange[400], Colors.white),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
