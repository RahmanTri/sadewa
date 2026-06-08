class Notice {
  final int id;
  final String title;
  String description = '';
  final String content;
  bool isRead = false;
  final String date;
  bool isDescCreated = false;

  Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.isRead,
    required this.date,
  });

  void hasBeenRead() {
    isRead = true;
  }

  void trimContent() {
    if (content.length > 71 && !isDescCreated) {
    description = '${content.substring(0, 71)}...';
    isDescCreated = true;
    }
  }



  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      isRead: (json['is_read'] as int) == 1,
      date: json['date'],
    );
  }
}