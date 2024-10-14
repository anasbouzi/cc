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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('categories');
        },
        backgroundColor: const Color.fromARGB(255, 151, 119, 238),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('home page'),
        actions: [
          IconButton(
              onPressed: () {
                GoogleSignIn googlesignin = GoogleSignIn();
                googlesignin.disconnect();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (rote) => false);
              },
              icon: const Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 160),
        children: [
          // Card(
          //   child: Container(
          //     padding: const EdgeInsets.all(10),
          //     child: Column(
          //       children: [
          //         Image.asset(
          //           'assets/images/folder.png',
          //           height: 100,
          //         ),
          //         const Text('Company')
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    ));
  }
}
