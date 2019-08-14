import "package:flutter/material.dart";
import "question.dart";
import "quiz.dart";
import "correctwrongoverlay.dart";
import "scorepage.dart";


class QuizPage extends StatefulWidget {

  final Quiz quiz;
  QuizPage(this.quiz);
  @override
  State createState() => new QuizPageState(this.quiz);
}

class QuizPageState extends State<QuizPage>{

  final double spacing = 15.0;
  final Quiz quiz;
  final userInputController = TextEditingController();



  QuizPageState(this.quiz);
  Question currentQuestion;

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;
/*
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userInputController.dispose();
    super.dispose();
  }
*/
  @override
  void initState(){
    super.initState();
    try {
        currentQuestion = quiz.nextQuestion;
        questionText = currentQuestion.question;
        questionNumber = quiz.questionNumber;

    } catch (error){
      Navigator.pop(context);
    }
  }


  Container displayDirections()
  {
    Text myText;
    if (questionText.contains(" ")){
      myText = new Text("Write the formula", style: new TextStyle(fontSize: 27.0), textAlign: TextAlign.center);
    }
    else {
      myText = new Text("Write the name", style: new TextStyle(fontSize: 27.0), textAlign: TextAlign.center);
    }
    return new Container(
        padding: new EdgeInsets.all(spacing),
        child: myText
    );
  }

  Container displayQuestion()
  {
    return new Container(
        padding: new EdgeInsets.all(spacing),
        child:  new Text(subscript(questionText), style: new TextStyle(fontSize: 27.0), textAlign: TextAlign.center)
    );

  }

  Container displayUserInput()
  {
    return new Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: new EdgeInsets.all(spacing),
        child: new TextField(
            controller: userInputController,

            textAlign: TextAlign.center,
            cursorColor: Theme.of(context).accentColor,
            autocorrect: false,
            style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.w900, fontSize: 23.0),

            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 3.0)),
            ),

            onEditingComplete: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              if (userInputController.text == "q") {
                userInputController.text = currentQuestion.answer;
              }
            }
        )
      );

  }


  Container displayCheckAnswer()
  {
    return new Container(
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width * 0.7,
        padding: new EdgeInsets.all(spacing),
        child: new RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
        onPressed: () {
            isCorrect = quiz.checkAnswer(userInputController.text, currentQuestion.answer);
            this.setState(() {
              overlayShouldBeVisible = true;
            });
            },
        child: Text("Submit Answer", style: new TextStyle(fontSize: 27.0))
    )
    );
  }

  Container displayCorrect()
  {
    return new Container(
        padding: new EdgeInsets.all(spacing/2),
        child:  new Text("Correct: " + quiz.correct.toString(), style: new TextStyle(fontSize: 27.0), textAlign: TextAlign.right)
    );
  }
  Container displayTotalQuestions()
  {
    return new Container(
        padding: new EdgeInsets.all(spacing/2),
        child:  new Text("Total Possible: " + (quiz.questionNumber - 1).toString(), style: new TextStyle(fontSize: 27.0), textAlign: TextAlign.right)
    );

  }

  Container leftContainer(BuildContext context)
  {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.33,
      alignment: Alignment.centerLeft,
        child: RaisedButton(
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Settings', style: new TextStyle(fontSize: 27.0)),
        ),
      );
  }

  Container middleContainer(BuildContext context)
  {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.8,
        alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              displayDirections(),
              displayQuestion(),
              displayUserInput(),
              displayCheckAnswer(),

            ]
        )


    );
  }

  Container rightContainer(BuildContext context)
  {
    return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        alignment: Alignment.topCenter,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              displayCorrect(),
              displayTotalQuestions()

            ]
        )
    );
  }



  TableRow topRow(BuildContext context){
    return TableRow(
      children: <Widget>[
        leftContainer(context)
      ],
    );
  }

  TableRow middleRow(BuildContext context)
  {
    return TableRow(
      children: <Widget>[
        middleContainer(context)
      ],
    );
  }

  TableRow bottomRow(BuildContext context)
  {
    return TableRow(
      children: <Widget>[
        rightContainer(context)
      ],
    );
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
  Widget build(BuildContext context){
    return new Stack(
      fit: StackFit.expand,
        children: <Widget>[
           Material(
            color: Theme.of(context).primaryColor,
              child:
                  Table(

                    children: [
                      topRow(context),
                      middleRow(context),
                      bottomRow(context)
                    ],
                  ),
            ),

         overlayShouldBeVisible  ? new CorrectWrongOverlay(
             isCorrect,
             currentQuestion.answer,
                 () {
                    if (quiz.length == questionNumber) {
                     Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.correct, quiz.length)), (Route route) => route == null);
                     return;
                    }
               this.setState(() {
                 userInputController.text = "";
                 overlayShouldBeVisible = false;
                 currentQuestion = quiz.nextQuestion;
                 questionText = currentQuestion.question;
                 questionNumber = quiz.questionNumber;
               }
               );
             }

         ) : new Container()

        ]
    );

  }


}

