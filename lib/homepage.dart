import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('home page'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googlesignin = GoogleSignIn();
                googlesignin.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (rote) => false);
              },
              icon: Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: ListView(
        children: [
          FirebaseAuth.instance.currentUser!.emailVerified
              ? Text('welcome')
              : MaterialButton(onPressed: (){FirebaseAuth.instance.currentUser!.sendEmailVerification();},child: Text('verifeidemail'),color: Colors.blue,)
        ],
      ),
    ));
  }
}
