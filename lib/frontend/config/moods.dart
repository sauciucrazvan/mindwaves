import 'package:flutter/material.dart';

final Map<String, Map<String, dynamic>> moods = {
  "Disastrous": {
    "icon": 'assets/animations/disastrous.json',
    "color": const Color(0xFF710627),
    "score": 0,
  },
  "Very Sad": {
    "icon": Icons.sentiment_very_dissatisfied,
    "color": const Color(0xFF81171B),
    "score": 1,
  },
  "Sad :(": {
    "icon": Icons.sentiment_dissatisfied,
    "color": const Color(0xFFAD2E24),
    "score": 2,
  },
  "Meh..": {
    "icon": Icons.sentiment_neutral,
    "color": const Color(0xFFCA5310),
    "score": 3,
  },
  "Okay": {
    "icon": Icons.sentiment_satisfied,
    "color": const Color(0xFF329F5B),
    "score": 4,
  },
  "Good!": {
    "icon": Icons.sentiment_very_satisfied,
    "color": const Color(0xFF0C8346),
    "score": 5,
  },
  "Excellent :D": {
    "icon": 'assets/animations/happy.json',
    "color": const Color(0xFF03A316),
    "score": 6,
  },
};