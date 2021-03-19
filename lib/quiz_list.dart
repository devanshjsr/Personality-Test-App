import 'database_services.dart';
import 'package:flutter/material.dart';

class QuizList extends StatefulWidget {
  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  Stream quizStream;
  DatabaseServices dbs = new DatabaseServices();

  Widget quizList() {
    return Container(
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue[800],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            //print(snapshot.data.documents.length);
                            itemBuilder: (context, index) {
                              return Quiz(
                                title: snapshot.data.documents[index]
                                    .data()["title"],
                                duration: snapshot.data.documents[index]
                                    .data()["duration_in_mins"],
                                totalQuetions: snapshot.data.documents[index]
                                    .data()["total_quetions"],
                                quizId: snapshot.data.documents[index]
                                    .data()["quizId"],
                              );
                            }),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  @override
  void initState() {
    dbs.getQuizInfo().then((value) {
      setState(() {
        quizStream = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: quizList(),
    );
  }
}

class Quiz extends StatelessWidget {
  final String title, duration, totalQuetions, quizId;

  Quiz(
      {@required this.title,
      @required this.duration,
      @required this.totalQuetions,
      @required this.quizId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            Text(title),
            Text(duration),
            Text(totalQuetions),
            Text(quizId),
          ],
        ),
      ),
    );
  }
}
