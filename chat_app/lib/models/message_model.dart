class MessageModel {
  String? messageId;
  String? sender;
  String? text;
  bool? seen;
  DateTime? createdon;

  MessageModel({
    this.messageId,
    this.sender,
    this.text,
    this.seen,
    this.createdon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId' : messageId,
      'sender': sender,
      'text': text,
      'seen': seen,
      'createdon': createdon?.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'] != null ? map['messageId'] as String : null,
      sender: map['sender'] != null ? map['sender'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
      seen: map['seen'] != null ? map['seen'] as bool : null,
      createdon: map['createdon'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdon'] as int)
          : null,
    );
  }
}
