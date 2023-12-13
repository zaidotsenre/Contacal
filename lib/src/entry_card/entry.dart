class Entry {
  int id;
  int calories;
  DateTime date;
  String? name;

  Entry(
      {required this.id,
      required this.calories,
      required this.date,
      this.name});
}
