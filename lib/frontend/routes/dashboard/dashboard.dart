// Generic imports
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mindwaves/frontend/config/palette.dart';
import 'package:mindwaves/frontend/routes/dashboard/components/mood_selector.dart';
import 'package:mindwaves/frontend/widgets/buttons/long_button.dart';
import 'package:mindwaves/frontend/widgets/fields/field.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController _pageController = PageController(
      viewportFraction: 0.35, initialPage: moodColors.length ~/ 2);
  final TextEditingController _detailsController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/MindwaveAppIcon.png",
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 4),
            Text(
              "Mindwaves",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
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
                Text(
                  "Today",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  DateFormat("MMM dd, yyyy").format(DateTime.now()),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "How was your day?",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                MoodSelector(pageController: _pageController),
                const Divider(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "What have you done today?",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      "(optional)",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Field(
                  textEditingController: _detailsController,
                  description: "Provide more details...",
                  maxLines: 4,
                  maxLength: 4096,
                  padding: 0,
                ),
                const SizedBox(height: 12),
                Center(
                  child: LongButton(
                    title: "Track the day",
                    icon: Icons.equalizer,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
