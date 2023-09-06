import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> Scorekeeper = [];
  void checkAnswer(bool userPickedAnswer)
  {
    bool correctAnswer = quizBrain.getquestionanswer();
    if(quizBrain.isFinished()==true)
      {
            setState(() {
              Alert(context: context, title: "Finished", desc: "You've reached the end.").show();
              quizBrain.reset();
              Scorekeeper=[];
            });
      }
    else
    {setState(() {
      if (userPickedAnswer == correctAnswer) {
        Scorekeeper.add(Icon(Icons.check,color: Colors.green,));
      }
      else {
        Scorekeeper.add(Icon(Icons.close, color: Colors.red,));
      }
      quizBrain.nextQuestion();
      }

    );}
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getquestiontext(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              child: Text(
                'True',
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () {
                checkAnswer(true);
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  elevation: 2,
                  backgroundColor: Colors.green[500]),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              child: Text(
                'False',
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () {
                checkAnswer(false);
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  elevation: 2,
                  backgroundColor: Colors.red),
            ),
          ),
        ),
        Row(
          children: Scorekeeper,
        ),
      ],
    );
  }
}
