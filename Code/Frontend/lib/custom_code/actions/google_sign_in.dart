// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:google_sign_in/google_sign_in.dart';

Future googleSignIn() async {
  const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/calendar.events',
  ];

  GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
          '512311205088-v4ngbrv8agt434rktvnqkpvv96jjv4kg.apps.googleusercontent.com',
      scopes: scopes);
  try {
    final account = await _googleSignIn.signInSilently();
    final auth = await account?.authentication;
    final accessToken = auth?.accessToken;
    return accessToken;
  } catch (error) {
    print(error);
  }
}
