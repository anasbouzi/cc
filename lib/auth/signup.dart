import 'package:cc/components/Button.dart';
import 'package:cc/components/CustomLogoAuth.dart';
import 'package:cc/components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 50, right: 20, left: 20),
          child: Form(
            key: formstate,
            child: ListView(
              children: [
                Logo(),
                const Text(
                  "Signup",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('UserName'),
                const SizedBox(
                  height: 13,
                ),
                CustomField(
                  hint: "Enter Your name",
                  mycontroler: username,
                  validator: (val) {
                    if (val == "") {
                      return "Can`t be empty";
                    }
                  },
                ),
                const Text('Email'),
                const SizedBox(
                  height: 13,
                ),
                CustomField(
                  hint: "Enter Your Email",
                  mycontroler: email,
                  validator: (val) {
                    if (val == "") {
                      return "Can`t be empty";
                    }
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                const Text('Password'),
                const SizedBox(
                  height: 13,
                ),
                CustomField(
                  hint: "Enter Your Password",
                  mycontroler: password,
                  validator: (val) {
                    if (val == "") {
                      return "Can`t be empty";
                    }
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                const Text(
                  'Forget password ?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatButtons(
                  title: "Signup",
                  onPressed: () async {
                    if (formstate.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        Navigator.of(context).pushReplacementNamed('login');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      print('not valid');
                    }
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 40),
                ),
                const SizedBox(
                  height: 45,
                ),
                InkWell(
                  onTap: () {

                    Navigator.of(context).pushReplacementNamed('login');
                  },
                  child: const Center(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: "Have An Acount ?"),
                      TextSpan(
                          text: " Login",
                          style: TextStyle(color: Colors.deepPurple)),
                    ])),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
