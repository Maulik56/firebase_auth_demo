import 'package:firebase_auth_demo/firebase_storage/firebase_storage_screen.dart';
import 'package:firebase_auth_demo/google/google_home_screen.dart';
import 'package:firebase_auth_demo/google/sign_in_google.dart';
import 'package:firebase_auth_demo/phone/by_enum/login_screen.dart';
import 'package:flutter/material.dart';

class Buttons extends StatefulWidget {
  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                signInWithGoogle().then(
                  (value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoogleHomeScreen(),
                    ),
                  ),
                );
              },
              child: Text("SignIn with Google"),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Text("Phone Verification")),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FirebaseStorageScreen(),
                    ),
                  );
                },
                child: Text("Firebase Storage")),
          ],
        ),
      ),
    );
  }
}
