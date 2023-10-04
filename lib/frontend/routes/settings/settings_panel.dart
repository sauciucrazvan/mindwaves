// Generic imports
import 'package:flutter/material.dart';

// Backend imports
import 'package:mindwaves/backend/services/tracker_service.dart';

// Frontend imports
import 'package:mindwaves/frontend/widgets/buttons/leading_button.dart';
import 'package:mindwaves/frontend/widgets/buttons/long_button.dart';
import 'package:mindwaves/frontend/widgets/dialogs/confirm_dialog.dart';

class SettingsPanel extends StatefulWidget {
  const SettingsPanel({super.key});

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/Mindwaves.png",
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
              // Settings title
              Text(
                "Settings panel",
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 16),

              // Settings options
              LongButton(
                title: "Clear history",
                trailing: const Icon(
                  Icons.manage_history,
                  size: 24,
                  color: Colors.white,
                ),
                color: Theme.of(context).colorScheme.secondary,
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => ConfirmDialog(
                      title:
                          "Are you sure you want to clear your entire history?\nThis action cannot be undone!",
                      confirm: () => TrackerService().clearData()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
