// Generic imports
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
          MapEntry mapEntry = moods.entries.elementAt(index);
          final color = mapEntry.value["color"];
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
                    if (mapEntry.value["icon"] is IconData)
                      Icon(
                        mapEntry.value["icon"],
                        color: Colors.white,
                        size: 32,
                      ),
                    if (mapEntry.value["icon"] is String)
                      Lottie.asset(
                        mapEntry.value["icon"],
                        width: 38,
                        height: 38,
                      ),
                    Text(
                      mapEntry.key,
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
