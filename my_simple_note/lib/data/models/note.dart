class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime modifiedAt;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.modifiedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'modified_at': modifiedAt.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.parse(map['created_at']),
      modifiedAt: DateTime.parse(map['modified_at']),
    );
  }

  Note copy({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }
}
