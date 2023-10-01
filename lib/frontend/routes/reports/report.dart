// Generic imports
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:graphic/graphic.dart';
import 'package:flutter/material.dart';

// Frontend imports
import 'package:mindwaves/frontend/config/moods.dart';
import 'package:mindwaves/frontend/routes/settings/settings_panel.dart';
import 'package:mindwaves/frontend/widgets/buttons/leading_button.dart';

class WeeklyReport extends StatelessWidget {
  const WeeklyReport({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;

    // Generate a map of colors for the graph
    List<Color> moodColors = [];
    moods.forEach((mood, details) => moodColors.add(details["color"]));

    // Get the maximum score that can be achieved every week
    int maxScore = 0;
    moods.forEach((key, value) {
      if (value["score"] > maxScore) maxScore = value["score"];
    });

    // Temporary random data, only for debug
    List<Map<String, dynamic>> dataMap = [
      {'day': 'Mon', 'score': Random().nextInt(maxScore) + 1},
      {'day': 'Tue', 'score': Random().nextInt(maxScore) + 1},
      {'day': 'Wed', 'score': Random().nextInt(maxScore) + 1},
      {'day': 'Thu', 'score': Random().nextInt(maxScore) + 1},
      {'day': 'Fri', 'score': Random().nextInt(maxScore) + 1},
      {'day': 'Sat', 'score': Random().nextInt(maxScore) + 1},
      {'day': 'Sun', 'score': Random().nextInt(maxScore) + 1},
    ];

    num totalScore =
        dataMap.fold(0, (num previousValue, Map<String, dynamic> element) {
      return previousValue + element['score'];
    });

    maxScore *= 7;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/Mindwaves.png",
          width: 32,
          height: 32,
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
        leading: const LeadingButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Report title
              Text(
                "Your weekly report",
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 16),

              // Weekly report graph
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width - 50,
                child: Chart(
                  data: dataMap,
                  variables: {
                    'day': Variable(
                      accessor: (Map map) => map['day'] as String,
                    ),
                    'score': Variable(
                      accessor: (Map map) => map['score'] as num,
                    ),
                  },
                  marks: [
                    IntervalMark(
                      color: ColorEncode(variable: 'score', values: moodColors),
                    )
                  ],
                  axes: [Defaults.horizontalAxis],
                ),
              ),

              const SizedBox(height: 16),

              // Score report
              Center(
                child: Column(
                  children: [
                    Text(
                      "Your weekly score is $totalScore/$maxScore.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Report generated on ${DateFormat('MMM dd, yyyy').format(DateTime.now())}.",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),

              // Improvements category ~ should be refactored in the future
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  "How can you improve your mood level?",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "AI Improvements is turned off in the settings.",
                style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPanel(),
                  ),
                ),
                child: const Text(
                  "Turn it on on the settings page.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
