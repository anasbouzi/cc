import 'package:cc/auth/login.dart';
import 'package:cc/auth/signup.dart';
import 'package:cc/firebase_options.dart';
import 'package:cc/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('===================User is currently signed out!');
      } else {
        print('===================User is signed in!');
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:(FirebaseAuth.instance.currentUser!=null && FirebaseAuth.instance.currentUser!.emailVerified) ? const Homepage():const Login(),
      routes: {
        'signup': (context) => const SignUp(),
        'login': (context) => const Login(),
        'homepage': (context) => const Homepage(),
      },
    );
  }
}
