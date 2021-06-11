class Todo {
  String uid;
  String title;
  String description;
  bool isComplet;
  DateTime currentDateTime;

  Todo(
      {this.uid,
      this.title,
      this.description,
      this.isComplet,
      this.currentDateTime});

  void toggleDone() {
    isComplet = !isComplet;
  }
}
