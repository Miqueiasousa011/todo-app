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

  ToDoModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? status,
  }) {
    return ToDoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}
