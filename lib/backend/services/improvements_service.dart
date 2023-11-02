// Generic imports
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// Backend imports
import 'package:mindwaves/backend/privates/chatgpt_key.dart';
import 'package:mindwaves/backend/services/tracker_service.dart';

class ImprovementsService {
  // Get the AI Improvements Caching Box
  Box improvementsBox = Hive.box("mindwaves_improvements");

  // Getting the data from the Tracker Service
  Map dataMap = TrackerService().getData();

  Map getWeeklyData() {
    Map factoryMap = {};

    // Looping through each value of the data
    dataMap.forEach((key, value) {
      DateTime dataDay = DateTime.parse(key);

      // Adding the data to the factory map only if it's in the last week
      if (dataDay.isAfter(DateTime.now().subtract(const Duration(days: 7)))) {
        factoryMap[key] = value;
      }
    });

    return factoryMap;
  }

  Future<String> generateText(String prompt) async {
    // Sending a request to the OpenAI API
    String url = 'https://api.openai.com/v1/chat/completions';
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getChatGPTKey()}'
      },
      body: jsonEncode({
        'messages': [
          {"role": "user", "content": prompt}
        ],
        'model': 'gpt-3.5-turbo',
      }),
    );

    return jsonDecode(response.body)['choices'][0]['message']['content'];
  }

  Future<String> generateImprovements() async {
    Map weeklyData = getWeeklyData(); // Getting the data
    String improvements = ""; // Creating a string that stores improvements

    // Looping through every tracked day of the week
    await Future.forEach(weeklyData.keys, (key) async {
      Map innerMap = weeklyData[key];

      if ((innerMap['details'] as String).isNotEmpty) {
        String response = await generateText(
            "Hey, what can I do to improve my day? This is what I did today: ${innerMap['details']} (please limit yourself to 50 characters)");

        improvements +=
            "\n• ${DateFormat('EEE').format(DateTime.parse(key))} » $response";
      }
    });

    return improvements;
  }

  Future<String> getImprovements(bool shouldRegenerate) async {
    if (shouldRegenerate) {
      String improvements = await generateImprovements();
      improvementsBox.put("improvements", improvements);
      return improvements;
    }

    String? improvements = improvementsBox.get("improvements");
    if (improvements == null || improvements.isEmpty) {
      return getImprovements(true);
    }
    return improvements;
  }

  void clearCache() => improvementsBox.clear();
}
