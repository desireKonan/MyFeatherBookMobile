import 'dart:ffi';

class Notes {
  int id = 0;
  String title = "";
  String content = "";
  DateTime createdDate = DateTime.now();
  DateTime? updatedDate;

  Notes(int id, String title, String content, DateTime createdDate,
      DateTime updatedDate);

  Notes.init();

  Notes copy(
          {int? id,
          String? title,
          String? content,
          DateTime? createdDate,
          DateTime? updatedDate}) =>
      Notes(id ?? this.id, title ?? this.title, content ?? this.content,
          createdDate ?? this.createdDate, updatedDate!);

  @override
  String toString() {
    return this.toJson().toString();
  }

  Map<String, Object?> toJson() => {
        "id": this.id,
        "title": this.title,
        "content": this.content,
        "createdDate": this.createdDate,
        "updatedDate": this.updatedDate
      };
}
