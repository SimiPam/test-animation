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

  static Todo fromJson(Map<String, Object> json) => Todo(
        uid: json['uid'] as String,
        isComplet: json['isComplet'] == 1,
        title: json['title'] as String,
        description: json['description'] as String,
        currentDateTime: DateTime.parse(json['currentDateTime'] as String),
        // selectedTime: TimeOfDay.fromDateTime(
        //     DateFormat.jm().parse(json[Todo.selectedTime] as String)),
        // selectedDate: DateTime.parse(json[Todo.selectedDate] as String),
      );
}
