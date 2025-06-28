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

import 'package:url_launcher/url_launcher.dart';

Future launch(
  String eventName,
  DateTime eventDate,
) async {
  final DateTime start = eventDate.toUtc();
  final DateTime end = start.add(Duration(hours: 1));
  print(start);
  print(end);
  String startString = start
          .toIso8601String()
          .replaceAll('-', '')
          .replaceAll(':', '')
          .split('.')
          .first +
      'Z';
  String endString = end
          .toIso8601String()
          .replaceAll('-', '')
          .replaceAll(':', '')
          .split('.')
          .first +
      'Z';

  String url = 'https://www.google.com/calendar/render?action=TEMPLATE'
      '&text=${Uri.encodeComponent(eventName)}'
      '&dates=$startString/$endString'
      '&details=${Uri.encodeComponent("Automatyczne przypomnienie o wydarzeniu.")}'
      '&sf=true&output=xml';

  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}
