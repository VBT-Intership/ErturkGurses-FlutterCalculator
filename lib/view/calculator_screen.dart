import 'package:flutter/material.dart';
import 'package:my_calculator_app/core/compenents/resultBoard.dart';
import 'package:my_calculator_app/view/keyboard.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  CalculatorScreen({Key key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  var rock;
  ContextModel cm = ContextModel();
  Parser p = Parser();
  String result = '';
  bool isResult = false;
  void _onPressed({String buttonText}) {
    setState(() {
      if (isResult) {
        result = '';
      }

      if (buttonText == '=') {
        if (result.isNotEmpty) {
          try {
            Expression exp = p.parse(result);

            result = (exp.evaluate(EvaluationType.REAL, cm)).toString();
            isResult = true;
          } catch (e) {
            print(e);
            showModalBottomSheet(
              
                context: context,
                builder: (BuildContext bc) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 10,
                    child: new Center(
                      child: Text('Eksik ya da hatalı ifade!'),
                    ),
                  );
                });
          }
        }
      } else if (buttonText == '<-') {
        if (result.isNotEmpty) {
          isResult = false;
          result = result.substring(0, result.length - 1);
        }
      } else {
        isResult = false;
        result += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          children: [
            ResultBoard(
              color: Colors.black,
              result: result,
            ),
            Keyboard(
              onTap: _onPressed,
            )
          ],
        ),
      ),
    );
  }
}
