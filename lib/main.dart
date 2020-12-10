import 'package:flutter/material.dart';
import 'package:quiz_app/loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quiz App",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: LoadingScreen(),
    );
  }
}
