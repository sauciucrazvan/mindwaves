// Generic imports
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:mindwaves/frontend/config/palette.dart';

// Frontend imports
import 'package:mindwaves/frontend/widgets/buttons/leading_button.dart';

class WeeklyReport extends StatelessWidget {
  const WeeklyReport({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;

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
                  data: const [
                    {'day': 'Mon', 'score': 4},
                    {'day': 'Tue', 'score': 1},
                    {'day': 'Wed', 'score': 3},
                    {'day': 'Thu', 'score': 4},
                    {'day': 'Fri', 'score': 1},
                    {'day': 'Sat', 'score': 2},
                    {'day': 'Sun', 'score': 5},
                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
