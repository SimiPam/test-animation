import 'package:animated_login_fb_app/model/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  CollectionReference todosCollection =
      FirebaseFirestore.instance.collection("Todos");

  Future createNewTodo(
    String title,
    String description,
    String userid,
  ) async {
    return await todosCollection.add({
      "title": title,
      "userid": userid,
      "isComplet": false,
      "description": description,
      "currentDatetime": FieldValue.serverTimestamp(),
    });
  }

  Future completTask(uid) async {
    await todosCollection.doc(uid).update({"isComplet": true});
  }

  Future updateTask(uid, String title, String description, bool isDone) async {
    await todosCollection.doc(uid).update({
      "isComplet": isDone,
      "title": title,
      "description": description,
    });
  }

  Future removeTodo(uid) async {
    await todosCollection.doc(uid).delete();
  }

  List<Todo> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      // return snapshot.docs.map((e) =>
      // Todo.fromJson(e.data())).toList();

      return snapshot.docs.map((e) {
        return Todo(
          isComplet: e.data()['isComplet'],
          title: e.data()["title"],
          description: e.data()["description"],
          userid: e.data()["userid"],
          uid: e.id,
        );
      }).toList();
    } else {
      return null;
    }
  }

  Stream<List<Todo>> listTodos(userid) {
    return todosCollection
        .where('userid', isEqualTo: userid)
        .snapshots()
        .map(todoFromFirestore);
  }
}
