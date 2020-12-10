import 'package:flutter/material.dart';
import 'package:quiz_app/home.dart';

class Resultpage extends StatefulWidget {
  int points;

  Resultpage({Key key, @required this.points}) : super(key: key);

  @override
  _resultpageState createState() => _resultpageState(points);
}

class _resultpageState extends State<Resultpage> {
  List<String> images = [
    "images/great.png",
    "images/good.png",
    "images/bad.png",
  ];

  String message;
  String image;

  @override
  void initState() {
    if (points < 20) {
      image = images[2];
      message = "Better luck next time!!\n" + "You scored $points points.";
    } else if (points < 35) {
      image = images[1];
      message = "Keep up the good work!!\n" + "You scored $points points.";
    } else {
      image = images[0];
      message = "Great job!!\n" + "You scored $points points.";
    }
    super.initState();
  }

  int points;

  _resultpageState(this.points);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Material(
              // elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        color: Colors.deepPurple[100],
                        width: 350.0,
                        height: 350.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: Center(
                          child: Text(
                            message,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Quicksand",
                            ),
                          ),
                        )),
                  ],
                ),
                color: Colors.deepPurple[100],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ));
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide:
                  BorderSide(width: 3.0, color: Colors.deepPurple[500]),
                  color: Colors.deepPurple[100],
                  splashColor: Colors.deepPurple[500],
                )
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.deepPurple[100],
    );
  }
}
