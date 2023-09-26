// Generic imports
import 'package:flutter/material.dart';

// Frontend imports
import 'package:mindwaves/frontend/config/palette.dart';

class MoodSelector extends StatefulWidget {
  final PageController pageController;

  const MoodSelector({super.key, required this.pageController});

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  Map<String, IconData> moodsInfo = {
    "Very Sad": Icons.sentiment_very_dissatisfied,
    "Sad :(": Icons.sentiment_dissatisfied,
    "Meh..": Icons.sentiment_neutral,
    "Okay": Icons.sentiment_satisfied,
    "Good!": Icons.sentiment_very_satisfied,
  };

  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget
        .pageController.initialPage; // Get the page initial from the controller
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: PageView.builder(
        controller: widget.pageController,
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
                  widget.pageController.animateToPage(
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
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
