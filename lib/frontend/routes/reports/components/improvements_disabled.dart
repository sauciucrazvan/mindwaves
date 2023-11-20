import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:mindwaves/backend/services/settings_service.dart';

class DisabledImprovementsError extends StatelessWidget {
  const DisabledImprovementsError({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsService settingsService = SettingsService();

    bool disableInformativeMessages =
        settingsService.getSettingValue("disable-informative-messages");

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
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset("assets/animations/ai.json",
                    width: 128, height: 128),
                Text(
                  "AI Improvements is turned off in the settings. Turn it on to receieve recommendations!",
                  style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (!disableInformativeMessages)
          Row(
            children: [
              Icon(Icons.info, color: Colors.red[400]),
              const SizedBox(width: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Text(
                  "Your information will be shared with OpenAI. Keep AI Improvements off if you want privacy.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
