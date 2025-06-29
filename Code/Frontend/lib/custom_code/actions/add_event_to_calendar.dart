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

import 'package:add_2_calendar/add_2_calendar.dart';

Future<String> addEventToCalendar(
  String eventName,
  DateTime eventDate,
) async {
  final Event event = Event(
    title: eventName,
    description: 'Automatyczne przypomnienie o wydarzeniu.',
    location: 'Online',
    startDate: eventDate,
    endDate: eventDate.add(const Duration(days: 1)),
    allDay: true,
  );

  await Add2Calendar.addEvent2Cal(event);
  return 'success';
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
