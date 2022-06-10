import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthLogin extends StatefulWidget {
  @override
  _FacebookAuthLoginState createState() => _FacebookAuthLoginState();
}

class _FacebookAuthLoginState extends State<FacebookAuthLogin> {
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            signInWithFacebook().then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Facebook login successful"),
                ),
              ),
            );
          },
          child: Text("Facebook Login"),
        ),
      ),
    );
  }
}
