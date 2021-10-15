import 'package:flash_chat/refactorCode/constant.dart';
import 'package:flash_chat/screens/massageBubble.dart';
import 'package:flash_chat/screens/streambuilder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
var loggedInUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final massageScreenControler = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String massageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  /*void getmassages() async {
    final massages =
        await _firestore.collection('massages').doc('UserID').get();

    var mapofData = massages.data();

    print(mapofData!['chat']);
  }*/

  // void massagesStream() async {
  //   await for (var snapshot in _firestore.collection('massages').snapshots()) {
  //     for (var massages in snapshot.docs) {
  //       print(massages.data);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
              onPressed: () {
                // getmassages();
                //massagesStream();
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)),
        ],
        title: Text('Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Streambuilder(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    cursorColor: Colors.white,
                    controller: massageScreenControler,
                    onChanged: (value) {
                      massageText = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Type your message here.....'),
                  )),
                  FlatButton(
                    onPressed: () {
                      massageScreenControler..clear();
                      _firestore.collection('massages').add({
                        'text': massageText,
                        'sender': loggedInUser.email,
                      });
                    },
                    child: Text('Send',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
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

class Streambuilder extends StatefulWidget {
  @override
  _StreambuilderState createState() => _StreambuilderState();
}

class _StreambuilderState extends State<Streambuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('massages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final massages = snapshot.data!.docs, reversed;
          List<MassageBubble> massageBubbles = [];
          for (var massage in massages) {
            final massageText = massage['text'];
            final massageSender = massage['sender'];

            final currentUser = loggedInUser.email;

            final massageBubble = MassageBubble(
                sender: massageSender,
                text: massageText,
                isMe: currentUser == massageSender);
            massageBubbles.add(massageBubble);
          }

          return Expanded(
              child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: massageBubbles,
          ));
        });
  }
}
