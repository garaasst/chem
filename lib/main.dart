import 'package:flutter/material.dart';
import 'package:flutter/services.dart' ;
import 'dart:async';
import "quizpage.dart";
import "quiz.dart";
import "question.dart";


void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_){
        runApp(MyApp());
      });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Chemistry Compound Trivia',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.blueAccent,
        backgroundColor: Colors.blueAccent,
        hintColor: Colors.amber,
        accentColor: Colors.amber,
        primaryTextTheme: Typography().white,
        textTheme: Typography().white,

      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget{
  HomePage createState() => HomePage();
}

class HomePage extends State<MainPage> {

  //ternary ionic changed to ionic with polyatomic ions
  //ternary charges changed to ionic with polyatomic ions and roman numerals
  bool acids = false;
  bool binaryIonic = false;
  bool binaryRoman = false;
  bool ternaryIonic = false;
  bool ternaryCharges = false;
  bool covalent = false;
  double textSize = 20.0;

  List<Question> tempQuestions = new List<Question>();

 void handleStartQuiz() async {
   switchToQuizPage(await generateQuestions());

 }
 void switchToQuizPage(List<Question> questions){
   Navigator.push(
     context,
     MaterialPageRoute(builder: (context) =>
         QuizPage(
             new Quiz(questions)
         )),
   );
 }

  Container displayDirections()
  {
    return new Container(
        padding: new EdgeInsets.all(10.0),
        child:  new Text("Please choose at least one category", style: new TextStyle(fontSize: 22.0, fontWeight: FontWeight.w900), textAlign: TextAlign.center)
    );
  }



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('assets/chemicalcompound.png'),
            displayDirections(),
            SwitchListTile(
              title: Text("Acids", style: new TextStyle(fontSize: textSize)),
              value: acids,
              onChanged: (bool value) =>
                  setState(() => acids = value),
            ),
            SwitchListTile(
              title: Text("Binary Ionic", style: new TextStyle(fontSize: textSize)),
              value: binaryIonic,
              onChanged: (bool value) =>
                  setState(() => binaryIonic = value),
            ),
            SwitchListTile(
              title: Text("Binary Ionic with Roman Numeral", style: new TextStyle(fontSize: textSize)),
              value: binaryRoman,
              onChanged: (bool value) =>
                  setState(() => binaryRoman = value),
            ),
            SwitchListTile(
              title: Text("Covalent", style: new TextStyle(fontSize: textSize)),
              value: covalent,
              onChanged: (bool value) =>
                  setState(() => covalent = value),
            ),
            SwitchListTile(
              title: Text("Ionic with Polyatomic Ions", style: new TextStyle(fontSize: textSize)),
              value: ternaryIonic,
              onChanged: (bool value) =>
                  setState(() => ternaryIonic = value),
            ),
            SwitchListTile(
              title: Text("Ionic with Polyatomic Ions & Roman Numerals", style: new TextStyle(fontSize: textSize)),
              value: ternaryCharges,
              onChanged: (bool value) =>
                  setState(() => ternaryCharges = value),
            ),
            Padding(

              padding: EdgeInsets.fromLTRB(8.0, screenHeight * 0.08,8.0,8.0),
              child: Container(
                height: screenHeight * 0.08,
                width: screenWidth * 0.5,
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    tempQuestions = new List<Question>();
                    if (selectedType()) {
                      handleStartQuiz();
                    } // end if
                  },
                  child: Text('Start Quiz', style: new TextStyle(fontSize: 27.0)),
                ),
              )
            ),

          ],
        ),
      ),
    );
  } // end homepage

  bool selectedType() {
    return acids || binaryIonic || binaryRoman ||
        ternaryIonic || ternaryCharges || covalent;
  }


  Future<List<Question>> generateQuestions() async  {

    if (acids) {
      await loadAsset("acids");
    }
    if (binaryIonic) {
      await loadAsset("binaryIonic");
    }
    if (binaryRoman) {
      await loadAsset("binaryRoman");
    }
    if (ternaryIonic) {
      await loadAsset("ternaryIonic");
    }
    if (ternaryCharges) {
      await loadAsset("ternaryCharges");
    }
    if (covalent) {
      await loadAsset("covalent");
    }
    return tempQuestions;

  }



   Future<void> loadAsset(String name) async {
    final myData = await rootBundle.loadString("assets/" + name + ".csv");
    List<String> rows = myData.split("\n");
    for (int i = 0; i < rows.length; i++) {
      List<String> words = rows[i].split(",");
      Question q1 = new Question(words[0], words[1]);
      Question q2 = new Question(words[1], words[0]);
      tempQuestions.add(q1);
      tempQuestions.add(q2);
    }
  }




}



