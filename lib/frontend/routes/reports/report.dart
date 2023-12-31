// Generic imports
import 'package:intl/intl.dart';
import 'package:graphic/graphic.dart';
import 'package:flutter/material.dart';

// Backend imports
import 'package:mindwaves/backend/services/tracker_service.dart';
import 'package:mindwaves/backend/services/settings_service.dart';

// Frontend imports
import 'package:mindwaves/frontend/config/moods.dart';
import 'package:mindwaves/frontend/routes/reports/components/improvements_box.dart';
import 'package:mindwaves/frontend/routes/reports/components/improvements_disabled.dart';
import 'package:mindwaves/frontend/widgets/buttons/leading_button.dart';

class WeeklyReport extends StatelessWidget {
  const WeeklyReport({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;

    // Generate a map of colors for the graph
    List<Color> moodColors = [];
    moods.forEach((key, value) => moodColors.add(value["color"]));

    // Get the maximum score that can be achieved every week
    int maxScore = 0;
    moods.forEach((key, value) {
      if (value["score"] > maxScore) maxScore = value["score"];
    });

    SettingsService settingsService = SettingsService();
    TrackerService trackerService = TrackerService();

    bool hideGraph = settingsService.getSettingValue('hide-graph-visibility');
    bool aiImprovements = settingsService.getSettingValue('ai-improvements');
    bool removeOldData = settingsService.getSettingValue('remove-old-data');

    // Get the user data and fetch it
    Map<dynamic, dynamic> dataMap = trackerService.getData();
    List<Map<String, dynamic>> chartData = [];

    if (dataMap.isNotEmpty) {
      dataMap.forEach((date, details) {
        DateTime reportDate = DateTime.parse(date);
        if (reportDate
            .isBefore(DateTime.now().subtract(const Duration(days: 7)))) {
          if (!removeOldData) return;
          trackerService
              .getDataMap()
              .delete(date); // Remove data if the user requests it
          return; // Keep a maximum of 7 days in the report
        }

        chartData.add({
          'day': "${DateFormat('E').format(reportDate)} ${details["feeling"]}",
          'score': details['score']
        });
      });
    }

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
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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

                if (!hideGraph && chartData.isNotEmpty) ...[
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
                          accessor: (Map map) => map['score'] as num,
                          scale: LinearScale(min: 0, max: maxScore / 7),
                        ),
                      },
                      marks: [
                        IntervalMark(
                          transition: Transition(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInOutCubic,
                          ),
                          color: ColorEncode(
                            variable: 'score',
                            values: moodColors,
                          ),
                        ),
                      ],
                      axes: [Defaults.horizontalAxis],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],

                // Score report
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Your weekly happiness score is ${((totalScore / maxScore) * 100).round()}%.",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
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

                (!aiImprovements
                    ? const DisabledImprovementsError()
                    : const ImprovementsBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
