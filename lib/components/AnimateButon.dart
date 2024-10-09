import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AnimatedButtonAuth extends StatelessWidget {
  final String title;
  void Function() pressEvent;
  //final Color color;
  AnimatedButtonAuth({super.key, required this.title,required this.pressEvent});

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      pressEvent: pressEvent,
      text: title,
      color:Colors.deepPurple ,
    );
  }
}
