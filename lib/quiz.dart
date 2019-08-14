import "question.dart";

class Quiz {
  List<Question> _questions = new List<Question>();
  int _currentQuestionIndex = -1;
  int _correct = 0;

  Quiz(this._questions){
    _questions.shuffle();
  }

  List<Question> get questions => _questions;

  int get length => _questions.length;

  int get questionNumber => _currentQuestionIndex + 1;

  int get correct => _correct;




  Question get nextQuestion {
    _currentQuestionIndex++;
    if ( _currentQuestionIndex >= length) return null;
    return _questions[_currentQuestionIndex];
  }

  bool checkAnswer(String guess, String answer){
    String userGuess = removeWhitespace(guess).toLowerCase();
    String actualAnswer = removeWhitespace(answer).toLowerCase();
    if (userGuess == actualAnswer){
      _correct++;
      return true;
    }
    return false;
  }

  String removeWhitespace(String str){
    return str.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
  }


}