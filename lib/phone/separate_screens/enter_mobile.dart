import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/phone/separate_screens/verify_otp.dart';

import 'package:flutter/material.dart';

class EnterMobile extends StatefulWidget {
  @override
  _EnterMobileState createState() => _EnterMobileState();
}

class _EnterMobileState extends State<EnterMobile> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;

  final _phoneController = TextEditingController();
  final _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _phoneController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter phone Number",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _auth
                    .verifyPhoneNumber(
                      phoneNumber: "+91${_phoneController.text}",
                      verificationCompleted: (phoneAuthCredential) async {},
                      verificationFailed: (verificationFailed) async {
                        _globalKey.currentState!.showSnackBar(
                          SnackBar(
                            content: Text(verificationFailed.message!),
                          ),
                        );
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          this.verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {},
                    )
                    .then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyOTP(
                            id: "$verificationId",
                          ),
                        )));
              },
              child: Text("Send Otp"),
            )
          ],
        ),
      ),
    );
  }
}
