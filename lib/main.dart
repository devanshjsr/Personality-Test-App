import 'package:flutter/material.dart';

void main() {
  runApp(MainClass());
}

class MainClass extends StatelessWidget {
  Widget answer() {
    return null;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quiz"),
        ),
        body: Column(
          children: <Widget>[
            Text("First Prime?"),
            ElevatedButton(child: Text("1"), onPressed: answer),
            ElevatedButton(child: Text("2"), onPressed: answer),
            ElevatedButton(child: Text("1"), onPressed: answer),
          ],
        ),
      ),
    );
  }
}
