import 'package:animated_login_fb_app/model/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  CollectionReference todosCollection =
      FirebaseFirestore.instance.collection("Todos");

  Future createNewTodo(String title, String description) async {
    return await todosCollection.add({
      "title": title,
      "isComplet": false,
      "description": description,
    });
  }

  Future completTask(uid) async {
    await todosCollection.doc(uid).update({"isComplet": true});
  }

  Future removeTodo(uid) async {
    await todosCollection.doc(uid).delete();
  }

  List<Todo> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Todo(
          isComplet: e.data()["isComplet"],
          title: e.data()["title"],
          description: e.data(),
          uid: e.id,
        );
      }).toList();
    } else {
      return null;
    }
  }

  Stream<List<Todo>> listTodos() {
    return todosCollection.snapshots().map(todoFromFirestore);
  }
}
