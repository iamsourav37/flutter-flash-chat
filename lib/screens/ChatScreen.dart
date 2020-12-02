import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'WelcomeScreen.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String ID = "chatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final auth = FirebaseAuth.instance;
  TextEditingController msgTextController = TextEditingController();
  User loggedInUser;
  String msgText;

  @override
  void initState() {
    this.getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    loggedInUser = auth.currentUser;
    if (loggedInUser != null) {
      print("Current user : ${loggedInUser.email}");
    } else {
      Navigator.pushNamed(context, WelcomeScreen.ID);
    }
  }

  sendMessage(String msgText) {
    _firebaseFirestore
        .collection('messages')
        .add({'sender': loggedInUser.email, 'msgText': msgText});
  }

  getMessages() async {
    final messages = await _firebaseFirestore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: Container(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              this.getMessages();
              // auth.signOut();
              // Navigator.pop(context);
            },
          ),
        ],
        title: Text('⚡️ Chat'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgTextController,
                      onChanged: (value) {
                        msgText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      msgTextController.clear();
                      this.sendMessage(msgText);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final messages = snapshot.data.docs;
        List<Text> messagesWidgets = [];
        for (var message in messages) {
          var data = message.data();
          final msgText = data['msgText'];
          final sender = data['sender'];
          messagesWidgets.add(Text("$msgText from $sender"));
        }
        return Column(
          children: messagesWidgets,
        );
      },
    );
  }
}
