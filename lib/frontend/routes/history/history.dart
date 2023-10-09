// Generic imports
import 'package:flutter/material.dart';

// Backend imports
import 'package:mindwaves/backend/services/tracker_service.dart';

// Frontend imports
import 'package:mindwaves/frontend/widgets/buttons/leading_button.dart';
import 'package:mindwaves/frontend/routes/history/components/day_container.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;

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
              // History title
              Text(
                "Viewing your history",
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 16),

              Expanded(
                child: ListView.builder(
                  itemCount: TrackerService().getData().length,
                  itemBuilder: (context, index) {
                    List<MapEntry<dynamic, dynamic>> entries =
                        TrackerService().getData().entries.toList();
                    MapEntry mapEntry = entries.reversed.elementAt(index);

                    return DayContainer(
                      id: mapEntry.key,
                      details: mapEntry.value['details'],
                      score: mapEntry.value['score'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
