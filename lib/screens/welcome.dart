import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/refactorCode/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.jpg'),
                    height: 70,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(color: Colors.black, fontSize: 40),
                  speed: const Duration(milliseconds: 100),
                  totalRepeatCount: 1,
                ),
              ],
            ),
            SizedBox(height: 40),
            RoundedButton(
                title: 'Log In',
                colour: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, 'login_screen');
                }),
            SizedBox(height: 2),
            RoundedButton(
                title: 'Resistration',
                colour: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, 'resistration_screen');
                }),
          ],
        ),
      ),
    );
  }
}
