class Diary {
  late int id;
  late String title;
  late String content;
  late DateTime createdDate;
  late DateTime updatedDate;

  Diary({
    required this.id,
    required this.title,
    required this.content,
    required this.createdDate,
    required this.updatedDate,
  });

  Diary.create(int id, String title, String content, DateTime createdDate,
      DateTime updatedDate)
      : this.id = id,
        this.title = title,
        this.content = content,
        this.createdDate = createdDate,
        this.updatedDate = updatedDate;

  Diary.init()
      : this.id = 0,
        this.title = "",
        this.content = "",
        this.createdDate = DateTime.now(),
        this.updatedDate = DateTime(0);

  @override
  String toString() {
    return "Note { id: $id, title: $title, content: $content, created_at: $createdDate, updated: $updatedDate }";
  }

  static Diary fromJson(Map<String, dynamic> dataJson) => Diary(
        id: dataJson['id'] as int,
        title: dataJson['title'] as String,
        content: dataJson['content'] as String,
        createdDate: DateTime.parse(dataJson['createDate'] as String),
        updatedDate: (dataJson['updateDate'] as String) != ""
            ? DateTime.parse((dataJson['updateDate'] as String))
            : DateTime(0),
      );

  Map<String, dynamic> toMap() => {
        //"id": this.id,
        "title": this.title,
        "content": this.content,
        "createDate": this.createdDate.toIso8601String(),
        "updateDate": this.updatedDate.toIso8601String()
      };
}
