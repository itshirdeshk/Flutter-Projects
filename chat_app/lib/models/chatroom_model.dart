class ChatRoomModel {
  String? chatroomid;
  Map<String, dynamic>? participants;
  String? lastMessage;

  ChatRoomModel(
      {this.chatroomid, this.participants, this.lastMessage});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatroomid': chatroomid,
      'participants': participants,
      'lastMessage': lastMessage,

    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      chatroomid:
          map['chatroomid'] != null ? map['chatroomid'] as String : null,
      participants: map['participants'] != null
          ? Map<String, dynamic>.from(
              (map['participants'] as Map<String, dynamic>))
          : null,
      lastMessage:
          map['lastMessage'] != null ? map['lastMessage'] as String : null,

    );
  }
}
