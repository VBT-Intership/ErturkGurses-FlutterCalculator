
import 'package:flutter/material.dart';

typedef void CalculatorButtonTapCallback({String buttonText});

class Button extends StatelessWidget {
  final color;
  final value;
  final textSize;
  const Button(this.value, {Key key, this.color, this.textSize, this.onTap})
      : super(key: key);
  final CalculatorButtonTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          child: Center(
              child: FlatButton(
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                    fontSize: textSize == null ? 20 : 50, color: Colors.white),
              ),
            ),
            onPressed: () => onTap(buttonText: value),
          )),
          decoration: BoxDecoration(
              color: color ?? Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }
}
