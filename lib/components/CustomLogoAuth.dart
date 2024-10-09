import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 25),
      child: Image.asset(
        'assets/images/fileman.png',
        height: 75,
      ),
    );
  }
}
