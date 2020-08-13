import 'package:flutter/material.dart';
import 'package:my_calculator_app/core/compenents/button.dart';

class Keyboard extends StatelessWidget {
  final CalculatorButtonTapCallback onTap;

  const Keyboard({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Row(
          children: [
            Button(
              '1',
              onTap: onTap,
            ),
            Button('2', onTap: onTap),
            Button('3', onTap: onTap),
            Button('+', color: Colors.orange, onTap: onTap),
          ],
        ),
        Row(
          children: [
            Button('4', onTap: onTap),
            Button('5', onTap: onTap),
            Button('6', onTap: onTap),
            Button('-', color: Colors.orange, onTap: onTap),
          ],
        ),
        Row(
          children: [
            Button('7', onTap: onTap),
            Button('8', onTap: onTap),
            Button('9', onTap: onTap),
            Button('*', color: Colors.orange, onTap: onTap),
          ],
        ),
        Row(
          children: [
            Button('0', onTap: onTap),
            Button('(', color: Colors.red, onTap: onTap),
            Button(')', color: Colors.red, onTap: onTap),
            Button('/', color: Colors.orange, onTap: onTap),
          ],
        ),
        Row(
          children: [
            Button('<-', color: Colors.green, textSize: 40, onTap: onTap),
            Button('=', color: Colors.green, textSize: 40, onTap: onTap)
          ],
        )
      ],
    ));
  }
}
