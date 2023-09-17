import 'package:chat_app/main.dart';
import 'package:chat_app/models/chatroom_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/chatroom_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const SearchPage(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  Future<ChatRoomModel> getChatRoomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where('participants.${widget.userModel.uid}', isEqualTo: true)
        .where('participants.${targetUser.uid}', isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var docData = snapshot.docs[0].data();

      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatRoom;
    } else {
      ChatRoomModel newChatRoom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        participants: {widget.userModel.uid: true, targetUser.uid: true},
      );
      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(newChatRoom.chatroomid)
          .set(newChatRoom.toMap());

      chatRoom = newChatRoom;
    }

    return chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search'),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
          TextField(
            controller: searchController,
            decoration: const InputDecoration(labelText: 'Email Address'),
          ),
          const SizedBox(
            height: 20,
          ),
          CupertinoButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                setState(() {});
              },
              child: const Text('Search')),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: searchController.text)
                .where('email', isNotEqualTo: widget.userModel.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                  if (dataSnapshot.docs.isNotEmpty) {
                    Map<String, dynamic> userMap =
                        dataSnapshot.docs[0].data() as Map<String, dynamic>;

                    UserModel searchedUser = UserModel.fromMap(userMap);

                    return ListTile(
                      onTap: () async {
                        ChatRoomModel? chatRoomModel =
                            await getChatRoomModel(searchedUser);

                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChatRoomPage(
                            targetUser: searchedUser,
                            userModel: widget.userModel,
                            firebaseUser: widget.firebaseUser,
                            chatroom: chatRoomModel,
                          );
                        }));
                      },
                      leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(searchedUser.profilePic)),
                      title: Text(searchedUser.fullname),
                      subtitle: Text(searchedUser.email),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                    );
                  } else {
                    return const Text('No results found!');
                  }
                } else if (snapshot.hasError) {
                  return const Text('Some Error Occured');
                } else {
                  return const Text('No results found!');
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ]),
      )),
    );
  }
}
