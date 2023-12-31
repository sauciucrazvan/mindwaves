// Generic imports
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// Backend imports
import 'package:mindwaves/backend/services/settings_service.dart';
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
    // Get the settings values
    SettingsService settingsService = SettingsService();
    dynamic apiKey = settingsService.getSettingValue("openai-key");
    bool useGPT4 = settingsService.getSettingValue("use-gpt4");

    if (apiKey is! String || apiKey.isEmpty) {
      return "An error occured: No API key provided!";
    }

    // Sending a request to the OpenAI API
    String url = 'https://api.openai.com/v1/chat/completions';
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({
        'messages': [
          {"role": "user", "content": prompt}
        ],
        'model': useGPT4 ? 'gpt-4' : 'gpt-3.5-turbo',
      }),
    );

    var responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 &&
        responseBody['choices'] != null &&
        responseBody['choices'].isNotEmpty) {
      return responseBody['choices'][0]['message']['content'];
    }

    return "An error occured: please check your API key or your OpenAI wallet.";
  }

  Future<String> generateImprovements() async {
    Map weeklyData = getWeeklyData(); // Getting the data
    String details = ""; // Creating a string that stores details

    // Looping through every tracked day of the week
    await Future.forEach(weeklyData.keys, (key) {
      Map innerMap = weeklyData[key];

      if (innerMap['score'] < 5) {
        if ((innerMap['details'] as String).isNotEmpty) {
          details +=
              "${DateFormat('EEEE').format(DateTime.parse(key))} (I was ${innerMap['feeling-title'] ?? '(null)'}) - ${innerMap['details']}";
        }
      }
    });

    if (details.isEmpty) return "No details provided in any tracked day!";

    // Gets the value of the complex recommendations
    bool longerRecommendations =
        SettingsService().getSettingValue('longer-recommendations');

    // Asking the AI how to improve the day (janky way of implementing it, i know)
    String prompt =
            "Hey, what can I do to improve my life? This is what I did this week:\n$details\nPlease limit yourself to ${longerRecommendations ? '256' : '128'} characters!",
        response = await generateText(prompt);

    return "Hey, this is what you can do to improve your life:\n\n$response";
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
