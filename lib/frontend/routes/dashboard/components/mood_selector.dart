// Generic imports
import 'package:flutter/material.dart';

// Frontend imports
import 'package:mindwaves/frontend/config/moods.dart';

class MoodSelector extends StatefulWidget {
  final PageController pageController;

  const MoodSelector({super.key, required this.pageController});

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
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
        itemCount: moods.length,
        onPageChanged: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          final color = moods.entries.elementAt(index).value["color"];
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
                      moods.entries.elementAt(index).value["icon"],
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      moods.entries.elementAt(index).key,
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
