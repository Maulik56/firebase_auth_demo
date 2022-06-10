import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/constant/const.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class FirebaseStorageScreen extends StatefulWidget {
  @override
  State<FirebaseStorageScreen> createState() => _FirebaseStorageScreenState();
}

class _FirebaseStorageScreenState extends State<FirebaseStorageScreen> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();

  final _password = TextEditingController();

  File? _image;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  Future<String?> uploadFile(File file, String filename) async {
    print("File path:${file.path}");
    try {
      var response = await firebase_storage.FirebaseStorage.instance
          .ref("user_image/$filename")
          .putFile(file);
      return response.storage.ref("user_image/$filename").getDownloadURL();
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> addData(
      {String? email,
      String? password,
      File? image,
      BuildContext? context}) async {
    String? imageUrl = await uploadFile(image!, 'demo.jpg');
    print("image url: $imageUrl");

    firebaseStorage
        .add({"email": email, "password": password, "image": imageUrl}).then(
            (value) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${_email.text} is added"),
        ),
      );
      _email.clear();
      _password.clear();
      clearimage();
    }).catchError(
      (e) {
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text("${_email.text} is not added $e"),
          ),
        );
      },
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          imageCache!.clear();
        } else {
          print("no Image selected");
        }
      },
    );
  }

  clearimage() {
    setState(
      () {
        print("remove:$_image");
        _image = null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Firebase Auth'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey)),
                  child: ClipOval(
                    child: _image == null
                        ? Image.network(
                            "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png",
                            fit: BoxFit.fill,
                          )
                        : Image.file(_image!),
                  ),
                ),
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(hintText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '*';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _password,
                decoration: InputDecoration(hintText: 'password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '*';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_email.text != "" &&
                      _password.text != "" &&
                      _image != null) {
                    addData(
                        email: _email.text,
                        password: _password.text,
                        image: _image,
                        context: context);
                  } else {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: Text("Some Field are blank"),
                            content:
                                Text("please enter username,email or profile"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Text("Ok"))
                            ],
                          );
                        });
                  }
                  print(_email.text);
                  print(_password.text);
                  print(_image);
                },
                child: Text('Get Storage'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
