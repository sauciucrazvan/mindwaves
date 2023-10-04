// Generic imports
import 'package:intl/intl.dart';
import 'package:graphic/graphic.dart';
import 'package:flutter/material.dart';

// Backend imports
import 'package:mindwaves/backend/services/tracker_service.dart';

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
    moods.forEach((key, value) => moodColors.add(value["color"]));

    List<double> scoreStops = [];
    moods.forEach(
        (key, value) => scoreStops.add((value['score'] as int).toDouble()));

    // Get the maximum score that can be achieved every week
    int maxScore = 0;
    moods.forEach((key, value) {
      if (value["score"] > maxScore) maxScore = value["score"];
    });

    // Get the user data and fetch it
    Map<dynamic, dynamic> dataMap = TrackerService().getData();
    List<Map<String, dynamic>> chartData = [];

    int dayCounter = 1;
    dataMap.forEach((date, details) {
      if (dayCounter > 7)
        return; // Keep a maximum of 7 days in the report | TODO: Remove the data if the user requested it

      chartData.add({
        'day': DateFormat('E').format(DateTime.parse(date)),
        'score': details['score']
      });
      dayCounter++;
    });

    num totalScore =
        chartData.fold(0, (num previousValue, Map<String, dynamic> element) {
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
                  data: chartData,
                  variables: {
                    'day': Variable(
                      accessor: (Map map) => map['day'] as String,
                    ),
                    'score': Variable(
                      accessor: (Map map) => map['score'] as int,
                    ),
                  },
                  marks: [
                    IntervalMark(
                      transition: Transition(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOutCubic),
                      color: ColorEncode(
                        variable: 'score',
                        values: moodColors,
                        stops: scoreStops,
                      ),
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
