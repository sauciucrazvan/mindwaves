// Generic imports
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// Front-end imports
import 'package:mindwaves/frontend/config/palette.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController _pageController =
      PageController(viewportFraction: 0.35, initialPage: 2);

  int selectedIndex = moodColors.length ~/ 2;

  Map<String, IconData> moodsInfo = {
    "Very Sad": Icons.sentiment_very_dissatisfied,
    "Sad": Icons.sentiment_dissatisfied,
    "Meh..": Icons.sentiment_neutral,
    "Okay": Icons.sentiment_satisfied,
    "Good!": Icons.sentiment_very_satisfied,
  };

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
        title: Image.asset(
          "assets/images/MindwaveAppIcon.png",
          width: 32,
          height: 32,
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
              const SizedBox(height: 24),
              SizedBox(
                height: 100,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: moodColors.length,
                  onPageChanged: (int index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final color = moodColors[index];
                    final scaleFactor = (index == selectedIndex) ? 0.9 : 0.75;

                    return Transform.scale(
                      scale: scaleFactor,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                            );
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: color,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                moodsInfo.values.elementAt(index),
                                color: Colors.white,
                                size: 32,
                              ),
                              Text(
                                moodsInfo.keys.elementAt(index),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
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
