// Generic imports
import 'package:intl/intl.dart';
import 'package:graphic/graphic.dart';
import 'package:flutter/material.dart';

// Frontend imports
import 'package:mindwaves/frontend/config/palette.dart';
import 'package:mindwaves/frontend/routes/settings/settings_panel.dart';
import 'package:mindwaves/frontend/widgets/buttons/leading_button.dart';

class WeeklyReport extends StatelessWidget {
  const WeeklyReport({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;

    const List<Map<String, dynamic>> dataMap = [
      {'day': 'Mon', 'score': 4},
      {'day': 'Tue', 'score': 1},
      {'day': 'Wed', 'score': 3},
      {'day': 'Thu', 'score': 4},
      {'day': 'Fri', 'score': 1},
      {'day': 'Sat', 'score': 2},
      {'day': 'Sun', 'score': 5},
    ];

    num totalScore =
        dataMap.fold(0, (num previousValue, Map<String, dynamic> element) {
      return previousValue + element['score'];
    });

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/MindwaveAppIcon.png",
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
                      "Your weekly score is $totalScore/35.",
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
