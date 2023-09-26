// Generic imports
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// Frontend imports
import 'package:mindwaves/frontend/config/palette.dart';
import 'package:mindwaves/frontend/routes/dashboard/components/mood_selector.dart';
import 'package:mindwaves/frontend/routes/history/history.dart';
import 'package:mindwaves/frontend/routes/reports/report.dart';
import 'package:mindwaves/frontend/routes/settings/settings_panel.dart';
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
                // Dashboard title
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

                // Mood selector title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "How was your day?",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                // Mood selector
                MoodSelector(pageController: _pageController),

                const Divider(),
                const SizedBox(height: 8),

                // Details field title
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

                // Details field
                Field(
                  textEditingController: _detailsController,
                  description: "Provide more details...",
                  maxLines: 4,
                  maxLength: 4096,
                ),

                const SizedBox(height: 12),

                // Track button
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: LongButton(
                      title: "Track the day",
                      icon: Icons.equalizer,
                      color: Theme.of(context).colorScheme.primary,
                      onTap: () {},
                    ),
                  ),
                ),

                const Divider(),
                const SizedBox(height: 16),

                // Quick access title
                Text(
                  "Quick access",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 12),

                // Quick access panel
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      LongButton(
                        title: "Weekly report",
                        icon: Icons.calendar_month,
                        color: Theme.of(context).colorScheme.secondary,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WeeklyReport(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      LongButton(
                        title: "View history",
                        icon: Icons.history,
                        color: Theme.of(context).colorScheme.secondary,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const History(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      LongButton(
                        title: "Settings",
                        icon: Icons.settings,
                        color: Theme.of(context).colorScheme.secondary,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPanel(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
