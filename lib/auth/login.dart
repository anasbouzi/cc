import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cc/components/Button.dart';
import 'package:cc/components/CustomLogoAuth.dart';
import 'package:cc/components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil(
      "homepage",
      (route) => false,
    );
  }

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
                const Logo(),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
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
                  title: "Login",
                  onPressed: () async {
                    if (formstate.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text);
                        if (credential.user!.emailVerified) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context)
                              .pushReplacementNamed("homepage");
                        } else {
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          AwesomeDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'Dialog Title',
                            desc: 'veriefed email',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          // ignore: avoid_print
                          print('No user found for that email.===============');
                        } else if (e.code == 'wrong-password') {
                          // ignore: avoid_print
                          print(
                              'Wrong password provided for that user.================');
                        }
                      }
                    } else {
                      // ignore: avoid_print
                      print('not valid');
                    }
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 40),
                  alignment: Alignment.center,
                  child: const Text(
                    'Or login with',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        signInWithGoogle();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(60)),
                        height: 60,
                        child: Image.asset(
                          'assets/images/google.png',
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(60)),
                        height: 60,
                        child: Image.asset(
                          'assets/images/facebook.png',
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(60)),
                        height: 60,
                        child: Image.asset(
                          'assets/images/twiter.png',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('signup');
                  },
                  child: const Center(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: "Don`t Have An Acount ?"),
                      TextSpan(
                          text: " Signup Now",
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
