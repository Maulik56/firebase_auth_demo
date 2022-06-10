import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../by_enum/home_screen.dart';
import 'next_screen.dart';

class VerifyOTP extends StatefulWidget {
  final String id;
  const VerifyOTP({required this.id});

  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final _globalKey = GlobalKey<ScaffoldState>();

  final _otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {});

      _globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
      print("======>>>>>${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _otpController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter OTP",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: widget.id,
                        smsCode: _otpController.text);
                signInWithPhoneAuthCredential(phoneAuthCredential);
                print("======>>>${widget.id}");
              },
              child: Text("Verify Otp"),
            ),
          ],
        ),
      ),
    );
  }
}
