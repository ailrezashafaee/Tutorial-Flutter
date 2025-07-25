class Todo {
  final String id;
  String title;
  final DateTime date;
  bool done;

  Todo({required this.title, DateTime? date, this.done = false, String? id})
    : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      date = date ?? DateTime.now();
}
