import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/quizpage.dart';

class Homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<Homepage> {
  List<String> images = [
    "images/art.png",
    "images/family.png",
    "images/education.png",
    "images/world.png",
    "images/gproblems.png",
  ];

  List<String> descriptions = [
    "Test your skill with Art topic!",
    "Try your hand at Family quiz!",
    "Prove your intelligence with Education topic!",
    "Show your erudition with Around the world quiz!",
    "Challenge yourself with Global problems topic!",
  ];

  Widget customcard(String topic, String image, String descriptions) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => getJSON(topic),
          ));
        },
        child: Material(
          color: Colors.deepPurple[500],
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    topic,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    descriptions,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontFamily: "Alike"),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz App",
          style: TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.deepPurple[500],
      ),
      body: ListView(
        children: <Widget>[
          customcard("Art", images[0], descriptions[0]),
          customcard("Family", images[1], descriptions[1]),
          customcard("Education", images[2], descriptions[2]),
          customcard("Around the world", images[3], descriptions[3]),
          customcard("Global problems", images[4], descriptions[4]),
        ],
      ),
      backgroundColor: Colors.deepPurple[100],
    );
  }
}
