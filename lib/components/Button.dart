import 'package:flutter/material.dart';

class ElevatButtons extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const ElevatButtons({super.key, required this.title,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 55),
        textStyle: const TextStyle(fontSize: 17),
        backgroundColor: Colors.deepPurple,
      ),
      child:  Text(title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
