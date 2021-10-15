import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const KMessageTextFieldDecoration = InputDecoration(
    border: InputBorder.none,
    hintText: '',
    hintStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.w500));

const kMessageContainerDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(32)),
    color: Colors.blueGrey);

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  focusedBorder: OutlineInputBorder(
    //borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  hintStyle: TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  ),
);
