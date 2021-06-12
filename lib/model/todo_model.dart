class Todo {
  String uid;
  String userid;
  String title;
  String description;
  bool isComplet;
  DateTime currentDateTime;

  Todo(
      {this.uid,
      this.userid,
      this.title,
      this.description,
      this.isComplet,
      this.currentDateTime});

  void toggleDone() {
    isComplet = !isComplet;
  }
}
