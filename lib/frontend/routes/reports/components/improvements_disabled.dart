import 'package:flutter/material.dart';

class DisabledImprovementsError extends StatelessWidget {
  const DisabledImprovementsError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            "How can you improve your mood level?",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "AI Improvements is turned off in the settings. Turn it on to receieve recommendations!",
          style: TextStyle(
            color: Colors.red[400],
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
