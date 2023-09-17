class UserModel {
  String uid;
  String fullname;
  String email;
  String profilePic;

  UserModel({
    required this.uid,
    required this.fullname,
    required this.email,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      fullname: map['fullname'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
    );
  }
}
