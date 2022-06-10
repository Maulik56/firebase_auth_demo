import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

///#FirebaseAuth:
FirebaseAuth kFirebaseAuth = FirebaseAuth.instance;

///#Firestore Database:
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
CollectionReference userCollection = firebaseFirestore.collection('users');
CollectionReference firebaseStorage =
    firebaseFirestore.collection('firebase_storage');
