class Todo {
  final String id;
  String title;
  final DateTime date;
  bool done;

  Todo({required this.title, DateTime? date, this.done = false, String? id})
    : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      date = date ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'done': done,
    'date': date.toIso8601String(),
  };

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      done: json['done'] as bool,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Todo copyWith({String? id, String? title, DateTime? date, bool? done}) {
    return Todo(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      done: done ?? this.done,
    );
  }
}
