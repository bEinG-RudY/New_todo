class ToDo {
  int? id;

  String todoName;
  String todoDate;
  bool isDone;

  ToDo({
    required this.todoName,
    required this.todoDate,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': todoName,
      'date': todoDate,
      'isDone': isDone ? 1 : 0,
    };
  }

  static ToDo fromMap(Map<String, dynamic> map) {
    return ToDo(
      todoName: map['name'],
      todoDate: map['date'],
      isDone: map['isDone'] == 1 ? true : false,
    );
  }
}
