import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  Future<void> addQuiz(Map quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz_List")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuetion(Map queData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz_List")
        .doc(quizId)
        .collection(quizId)
        .add(queData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<Stream> getQuizInfo() async {
    return await FirebaseFirestore.instance.collection("Quiz_List").snapshots();
  }
}
