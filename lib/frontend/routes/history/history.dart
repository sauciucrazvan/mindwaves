// Generic imports
import 'package:flutter/material.dart';

// Frontend imports
import 'package:mindwaves/frontend/widgets/buttons/leading_button.dart';

class History extends StatelessWidget {
  const History({super.key});

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
              // History title
              Text(
                "Viewing your history",
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
