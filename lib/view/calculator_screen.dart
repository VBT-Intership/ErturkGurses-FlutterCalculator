import 'package:flutter/material.dart';
import 'package:my_calculator_app/calculator.dart';
import 'package:my_calculator_app/core/compenents/resultBoard.dart';
import 'package:my_calculator_app/view/keyboard.dart';

class CalculatorScreen extends StatefulWidget {
  CalculatorScreen({Key key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String result = " ";
  bool isResult = false;
  void _onPressed({String buttonText}) {
    setState(() {
      if (isResult) {
        result = ' ';
      }

      if (buttonText == '<-' && result != ' ') {
        isResult = false;

        result = result.substring(0, result.length - 1);
      } else if (buttonText == '=') {
        isResult = true;
        double _result;

        try {
          // Girdiyi infix/prefix dönüşümü için hazırladık, ters çevirdik
          var reversedInput = Calculator.reverseEquation(result);

          // Çevrilmiş stringi daha rahat kullanabilmek adına stack içine yerleştirdik
          var equationStack = Calculator.stringToStack(reversedInput);

          // Infixten postfixe geçiş yaptık
          var postfixEquationStack = Calculator.infixToPostfix(equationStack);

          // Sonucu hesaplayıp ekrana yazdık.
          _result = Calculator.calculateFromPrefix(postfixEquationStack);
          if (_result == double.infinity) {
            print(
                '\nBir sayı sıfıra bölünemez. Lütfen girdiyi kontrol ediniz\n');
          } else {
            result = _result.toString();
          }
        } catch (e) {
          _result = 0;
          showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return Container(
                  height: MediaQuery.of(context).size.height / 10,
                  child: new Center(
                    child: Text('HATALI İFADE'),
                  ),
                );
              });
        }
        ;
      } else if (buttonText != '<-' &&
          buttonText != '==' &&
          result.length <= 45) {
        isResult = false;

        result += buttonText;
      }
      print('result: ' + result + '|');
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
