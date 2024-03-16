class ToDoModel {
  int? id;
  String? title;
  String? description;
  bool status;

  ToDoModel({
    this.id,
    this.title,
    this.description,
    this.status = false,
  });
}
