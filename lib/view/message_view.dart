class MessageView {
  bool rightSide;
  String content;
  int type;
  bool tag;
  bool favorite;
  DateTime time;
  bool autoPlay;
  MessageView({
    required this.content,
    this.rightSide = true,
    this.type = 1,
    this.tag = false,
    this.favorite = false,
    this.autoPlay = false,
    DateTime? time, // Sử dụng DateTime? để đánh dấu là tham số có thể null
  }) : time = time ??
            DateTime.now(); // Sử dụng null-aware operator để xử lý giá trị null
}
