import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'enter_mobile.dart';

class NextScreen extends StatefulWidget {
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Next Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _auth.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EnterMobile(),
            ),
          );
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
