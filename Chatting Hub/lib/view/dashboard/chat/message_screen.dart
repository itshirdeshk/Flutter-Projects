import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

import '../../../utils/utils.dart';

class MessageScreen extends StatefulWidget {
  final String name, image, email, receiverId;
  const MessageScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.email,
      required this.receiverId});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Chat');
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: 100,
                      itemBuilder: (context, index) {
                        return Text(index.toString());
                      })),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        controller: messageController,
                        cursorColor: AppColors.primaryTextTextColor,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(height: 0, fontSize: 20),
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              sendMessage();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: CircleAvatar(
                                backgroundColor: AppColors.primaryIconColor,
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          hintText: "Enter message",
                          contentPadding: EdgeInsets.all(20),
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    height: 0,
                                    color: AppColors.primaryTextTextColor
                                        .withOpacity(0.8),
                                  ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.textFieldDefaultBorderColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondaryColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.alertColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryTextTextColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      ),
                    )),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  sendMessage() {
    if (messageController.text.isEmpty) {
      Utils.toastMessage("Enter message");
    } else {
      final timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
      ref.child(timeStamp).set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'receiver': widget.receiverId,
        'type': 'text',
        'time': timeStamp.toString(),
      }).then((value) {
        messageController.clear();
      }).onError((error, stackTrace) {});
    }
  }
}
