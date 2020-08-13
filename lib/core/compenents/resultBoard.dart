import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ResultBoard extends StatefulWidget {
  final color;
  final result;
  final flexNumber;
  const ResultBoard({Key key, this.color, this.result, this.flexNumber})
      : super(key: key);

  @override
  _ResultBoardState createState() => _ResultBoardState();
}

class _ResultBoardState extends State<ResultBoard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          decoration: BoxDecoration(color: widget.color ?? Colors.amber),
          child: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: AutoSizeText(
                  widget.result,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.1),
                )),
          )),
    );
  }
}
