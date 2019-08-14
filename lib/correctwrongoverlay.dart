import 'dart:math';
import 'package:flutter/material.dart';

class CorrectWrongOverlay extends StatefulWidget {

  final bool _isCorrect;
  final VoidCallback _onTap;
  final String _answer;

  CorrectWrongOverlay(this._isCorrect, this._answer, this._onTap);

  @override
  State createState() => new CorrectWrongOverlayState();
}

class CorrectWrongOverlayState extends State<CorrectWrongOverlay> with SingleTickerProviderStateMixin {

  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(duration: new Duration(seconds: 2), vsync: this);
    _iconAnimation = new CurvedAnimation(parent: _iconAnimationController, curve: Curves.elasticOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  String subscript(String str) {
    String output = "";
    for (int i = 0; i < str.length; i++)
    {
      var char = str[i];
      if (char == "0") {
        output += '\u2080';
      } else if ( char == "1"){
        output += '\u2081';
      } else if ( char == "2"){
        output += '\u2082';
      } else if ( char == "3"){
        output += '\u2083';
      } else if ( char == "4"){
        output += '\u2084';
      } else if ( char == "5"){
        output += '\u2085';
      } else if ( char == "6"){
        output += '\u2086';
      } else if ( char == "7"){
        output += '\u2087';
      } else if ( char == "8"){
        output += '\u2088';
      } else if ( char == "9"){
        output += '\u2089';
      } else {
        output += char;
      }
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: widget._isCorrect ?  Colors.green : Colors.red,
      child: new InkWell(
        onTap: () => widget._onTap(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
              ),
              child: new Transform.rotate(
                angle: _iconAnimation.value * 2 * pi,
                child: new Icon(widget._isCorrect == true ? Icons.done : Icons.clear, size: _iconAnimation.value * 80.0,),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(bottom: 20.0),
            ),
            new Text(widget._isCorrect == true ? "Correct!" : "Wrong!", style: new TextStyle(color: Colors.white, fontSize: 30.0)),
           new Text( widget._isCorrect == false ? subscript(widget._answer): "",style: new TextStyle(color: Colors.white, fontSize: 30.0) )

          ],
        ),
      ),
    );
  }
}