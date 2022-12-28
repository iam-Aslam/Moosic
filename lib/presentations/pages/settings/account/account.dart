import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moosic/presentations/widgets/common.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String? file;
  ImagePicker image = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        headerpages(context),
        GetImage(),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 300,
            height: 50,
            child: TextField(
              // keyboardType: TextInputType.number,
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outlined,
                  color: Colors.deepPurpleAccent,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: 'Enter Name',
                filled: true,
                // fillColor: Colors.brown[100],
                isDense: true, // Added this
                contentPadding: const EdgeInsets.all(18),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 300,
            height: 50,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.phone_android,
                  color: Colors.deepPurpleAccent,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: 'Enter Phone',
                filled: true,
                // fillColor: Colors.brown[100],
                isDense: true, // Added this
                contentPadding: const EdgeInsets.all(18),
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Colors.deepPurpleAccent, // background (button) color
            foregroundColor: Colors.white, // foreground (text) color
          ),
          onPressed: () {},
          child: Text('Update'),
        )
      ],
    )));
  }

//add student on clicking button
// Future<void> Addstudentbtn() async {
//   final _name = _nameController.text.trim();
//   final _age = _ageController.text.trim();

//   if (_name.isEmpty || _age.isEmpty) {
//     return;
//   }
//   //print('$_name $_age $_domain $_place');

//   final _student = StudentModel(
//       name: _name, age: _age, domain: _domain, place: _place, image: file!);
//   addStudent(_student);
// }

// image pick from gallery
  getgallery() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(
        () {
          file = img.path;
        },
      );
    }
  }

  // image picking UI
  Widget GetImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 100,
          backgroundImage: file == null
              ? AssetImage('assets/images/profile.jpg') as ImageProvider
              : FileImage(File(file!)),
        ),
        Positioned(
            bottom: 10,
            right: 25,
            child: InkWell(
                child: const Icon(
                  Icons.photo,
                  color: Colors.black,
                  size: 30,
                ),
                onTap: () {
                  getgallery();
                })),
      ],
    );
  }
}
