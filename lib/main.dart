import 'dart:convert';

import 'package:firebase_auth_demo/facebook_login/facebook_auth.dart';
import 'package:firebase_auth_demo/firestore_database/cloud_database.dart';
import 'package:firebase_auth_demo/phone/by_enum/home_screen.dart';
import 'package:firebase_auth_demo/phone/separate_screens/enter_mobile.dart';
import 'package:firebase_auth_demo/phone/by_enum/login_screen.dart';
import 'package:firebase_auth_demo/view/buttons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'facebook_login/fb_login_demo.dart';
import 'firebase_storage/firebase_storage_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EnterMobile(),
    );
  }
}
