import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/massageBubble.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
var loggedInUser;

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
