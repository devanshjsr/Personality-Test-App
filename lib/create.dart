import 'package:flutter_app/database_services.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String totalQuetions, quizTitle, duration, quizId;

  DatabaseServices dbs = new DatabaseServices();

  bool _loadingIndicator = false;

  void add() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loadingIndicator = true;
      });

      quizId = randomAlphaNumeric(11);
      Map<String, String> dataMap = {
        "quizId": quizId,
        "title": quizTitle,
        "duration_in_mins": duration,
        "total_quetions": totalQuetions
      };

      await dbs.addQuiz(dataMap, quizId);

      setState(() {
        _loadingIndicator = false;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AddQuetions(quizId)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _loadingIndicator
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(top: 15, left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      // style: TextStyle(fontSize: 10),
                      decoration: InputDecoration(
                        labelText: 'Quiz Title',
                        // errorStyle: TextStyle(fontSize: 8),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null) {
                          return "Enter Quiz Title";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) => quizTitle = value,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // style: TextStyle(fontSize: 10),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Total Quetions',
                        // errorStyle: TextStyle(fontSize: 8),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null) {
                          return "Enter Number of Quetions";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) => totalQuetions = value,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // style: TextStyle(fontSize: 10),
                      decoration: InputDecoration(labelText: 'Duration'
                          // errorStyle: TextStyle(fontSize: 8),
                          ),
                      keyboardType: TextInputType.datetime,

                      textInputAction: TextInputAction.next,

                      validator: (value) {
                        if (value == null) {
                          return "Enter Quiz Duration";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) => duration = value,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        add();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor),
                        child: Text(
                          'Create Quiz',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
