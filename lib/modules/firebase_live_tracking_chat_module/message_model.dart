

class Message {
  final String? sender;
  final String ?time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String ?text;
  final bool ?unread;
  final String ?type;

  Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
    this.type,
  });
}
