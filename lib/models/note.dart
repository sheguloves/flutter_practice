class Note {
  Note({
    required this.id,
    required this.title,
    required this.content,
    this.favorite = false,
  });

  final String id;
  final String title;
  final String content;
  bool favorite = false;

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'],
        content = json['content'],
        favorite = json['favorite'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'favorite': favorite,
  };
}