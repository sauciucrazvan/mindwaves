// Generic imports
import 'package:flutter/material.dart';

// Backend imports
import 'package:mindwaves/backend/services/settings_service.dart';
import 'package:mindwaves/backend/services/improvements_service.dart';

class ImprovementsBox extends StatelessWidget {
  const ImprovementsBox({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsService settingsService = SettingsService();

    bool disableInformativeMessages =
        settingsService.getSettingValue("disable-informative-messages");

    return Column(
      children: [
        Row(
          children: [
            Text(
              "Improvements",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "EXPERIMENTAL",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: FutureBuilder(
              future: ImprovementsService().getImprovements(),
              builder: (context, snapshot) => Text(
                "Hey, this is what you can do to improve your life:\n${snapshot.data}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (!disableInformativeMessages)
          Row(
            children: [
              Icon(Icons.info, color: Colors.red[400]),
              const SizedBox(width: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Text(
                  "This is just a prototype. Informations might not be accurate, if you have mental problems please talk with a specialist.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
