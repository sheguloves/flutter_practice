class Note {
  Note({
    required this.id,
    required this.title,
    required this.content,
  });

  final String id;
  final String title;
  final String content;
  bool selected = false;

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'],
        content = json['content'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
  };
}