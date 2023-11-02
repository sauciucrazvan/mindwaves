// Generic imports
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

// Backend imports
import 'package:mindwaves/backend/services/settings_service.dart';
import 'package:mindwaves/backend/services/improvements_service.dart';
import 'package:mindwaves/frontend/widgets/dialogs/confirm_dialog.dart';
import 'package:mindwaves/frontend/widgets/notifications/elevated_notification.dart';

class ImprovementsBox extends StatefulWidget {
  const ImprovementsBox({super.key});

  @override
  State<ImprovementsBox> createState() => _ImprovementsBoxState();
}

class _ImprovementsBoxState extends State<ImprovementsBox> {
  String _improvementsText = "";

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
              future: ImprovementsService().getImprovements(false),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _improvementsText = snapshot.data!;
                } else {
                  _improvementsText =
                      "No data receieved. Check your OpenAI credit!";
                }

                return Text(
                  "Hey, this is what you can do to improve your life:\n$_improvementsText",
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) => ConfirmDialog(
                title:
                    "Are you sure you want to regenerate the AI Improvements?",
                confirm: () async {
                  String newImprovementsText =
                      await ImprovementsService().getImprovements(true);
                  setState(() {
                    _improvementsText = newImprovementsText;
                  });

                  showElevatedNotification(
                    context,
                    "Action completed succesfully.",
                    Colors.lightGreen.shade700,
                  );
                  Navigator.pop(context);
                },
              ),
            ),
            child: Text(
              "Regenerate improvements",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]),
        const SizedBox(height: 8),
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
