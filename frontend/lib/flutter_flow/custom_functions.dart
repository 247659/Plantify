import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

String? truncateText(
  String text,
  int limit,
) {
  if (text.length <= limit) {
    return text;
  }
  return '${text.substring(0, limit)}...';
}

String? wateringBenchmark(
  String? value,
  String? unit,
) {
  if (value == null || value == "0" || unit == null || unit.isEmpty) {
    return null;
  }
  String text = "$value $unit";
  return text;
}

String? originToLine(List<String>? countries) {
  if (countries == null || countries.isEmpty) {
    return 'No information';
  }

  return countries.join(', ');
}

String? plantAnatomy(
  String? part,
  List<String>? color,
) {
  if (part == null || part.isEmpty) {
    return null;
  }

  if (color == null || color.isEmpty) {
    return part;
  }

  String colors = color.join(', ');
  return '$part ($colors)';
}

String? pruningCount(
  int? amount,
  String? interval,
) {
  if (amount == 0 || interval == null) {
    return null;
  }

  String text = '$amount $interval';
  return text;
}

String? dimensionToLine(
  int? min,
  int? max,
  String? unit,
) {
  if (min == null || max == null || unit == null) {
    return null;
  }

  int minimum = min;
  int maximum = max;

  if (unit == "feet") {
    minimum = (min * 30.48).round();
    maximum = (max * 30.48).round();
  }

  String text;

  if (minimum == maximum) {
    text = "$minimum cm";
  } else {
    text = "$minimum - $maximum cm";
  }

  return text;
}

dynamic convertToJson(
  String? content,
  String? role,
) {
  final safeJson = jsonEncode({
    'role': role,
    'message': content,
  });
  return json.decode(safeJson);
}

bool checkBlankString(String? word) {
  if (word == null) return true;
  return word.trim().isEmpty;
}
