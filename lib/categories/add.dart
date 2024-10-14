import 'package:cc/components/textformfieldadd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  Future<void> addUser() async {
    // Call the user's CollectionReference to add a new user
    if (formstate.currentState!.validate()) {
      try {
        await categories.add({
          'name': name.text,
        });
        Navigator.of(context).pushReplacementNamed('homepage');
      } catch (e) {
        Text('$e'); // Handle the error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add actegories'),
      ),
      body: Form(
          key: formstate,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: CustomFieldAdd(
                    hint: 'enter name',
                    mycontroler: name,
                    validator: (val) {
                      if (val == '') {
                        return 'can`t be empty';
                      }
                      return null;
                    }),
              ),
              MaterialButton(
                onPressed: () {
                  addUser();
                },
                color: Colors.deepPurple,
                textColor: Colors.white,
                elevation: 15,
                child: const Text('Add'),
              )
            ],
          )),
    );
  }
}
