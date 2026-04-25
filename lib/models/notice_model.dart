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
    // required this.description,
    required this.content,
    // required this.isRead,
    required this.date,
  });

  void hasBeenRead() {
    isRead = true;
  }

  void trimContent() {
    if (content.length > 71 && !isDescCreated) {
    description = '${content.substring(0, 71)}...';
    }
  }



  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'],
      title: json['judul'],
      // description: json['deskripsi'],
      content: json['content'],
      // isRead: json['isRead'],
      date: json['tanggal'],
    );
  }
}