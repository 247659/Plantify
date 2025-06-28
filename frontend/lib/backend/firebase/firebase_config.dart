import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAUVokIEqaMWtj_ZO82A9jkR7LW46Tii_Y",
            authDomain: "frontend-v1j2ba.firebaseapp.com",
            projectId: "frontend-v1j2ba",
            storageBucket: "frontend-v1j2ba.firebasestorage.app",
            messagingSenderId: "327402471078",
            appId: "1:327402471078:web:036234867b3a464fc73e67",
            measurementId: "G-89FS6L40DP"));
  } else {
    await Firebase.initializeApp();
  }
}
