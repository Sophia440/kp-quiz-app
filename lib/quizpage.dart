import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/resultpage.dart';

class getJSON extends StatelessWidget {
  String topic;

  getJSON(this.topic);

  String assetToLoad;

  setAsset() {
    if (topic == "Art") {
      assetToLoad = "assets/art.json";
    } else if (topic == "Family") {
      assetToLoad = "assets/family.json";
    } else if (topic == "Education") {
      assetToLoad = "assets/education.json";
    } else if (topic == "Around the world") {
      assetToLoad = "assets/world.json";
    } else {
      assetToLoad = "assets/gproblems.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    setAsset();
    return FutureBuilder(
      future:
      DefaultAssetBundle.of(context).loadString(assetToLoad, cache: false),
      builder: (context, snapshot) {
        List myData = json.decode(snapshot.data.toString());
        if (myData == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading",
              ),
            ),
          );
        } else {
          return Quizpage(myData: myData);
        }
      },
    );
  }
}

class Quizpage extends StatefulWidget {
  final List myData;

  Quizpage({Key key, @required this.myData}) : super(key: key);

  @override
  _quizpageState createState() => _quizpageState(myData);
}

class _quizpageState extends State<Quizpage> {
  final List myData;

  _quizpageState(this.myData);

  Color colorToShow = Colors.deepPurple[500];
  Color right = Colors.green;
  Color wrong = Colors.red;
  int points = 0;
  int i = 1;
  bool disableAnswer = false;
  int timer = 30;
  String showTimer = "30";

  Map<String, Color> buttonColor = {
    "a": Colors.deepPurple[500],
    "b": Colors.deepPurple[500],
    "c": Colors.deepPurple[500],
  };

  bool cancelTimer = false;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void startTimer() async {
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextQuestion();
        } else if (cancelTimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextQuestion() {
    cancelTimer = false;
    timer = 30;
    setState(() {
      if (i < 10) {
        i++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Resultpage(points: points),
        ));
      }
      buttonColor["a"] = Colors.deepPurple[500];
      buttonColor["b"] = Colors.deepPurple[500];
      buttonColor["c"] = Colors.deepPurple[500];
      disableAnswer = false;
    });
    startTimer();
  }

  void checkAnswer(String k) {
    if (myData[2][i.toString()] == myData[1][i.toString()][k]) {
      points = points + 5;
      colorToShow = right;
    } else {
      colorToShow = wrong;
    }
    setState(() {
      buttonColor[k] = colorToShow;
      cancelTimer = true;
      disableAnswer = true;
    });
    Timer(Duration(seconds: 1), nextQuestion);
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: RawMaterialButton(
        onPressed: () => checkAnswer(k),
        shape: StadiumBorder(),
        child: Text(
          myData[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        fillColor: buttonColor[k],
        splashColor: Colors.deepPurple[700],
        highlightColor: Colors.deepPurple[700],
        constraints: BoxConstraints.tight(Size(200, 45)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Quiz App",
              ),
              content: Text("Finish the quiz to return."),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Ok',
                  ),
                )
              ],
            ));
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  myData[0][i.toString()],
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: "Quicksand",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: AbsorbPointer(
                absorbing: disableAnswer,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      choiceButton('a'),
                      choiceButton('b'),
                      choiceButton('c'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showTimer,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}
