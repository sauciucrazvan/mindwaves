// Generic imports
import 'package:flutter/material.dart';

// Backend imports
import 'package:mindwaves/backend/services/tracker_service.dart';
import 'package:mindwaves/backend/services/settings_service.dart';

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
  final SettingsService _settingsService = SettingsService();

  bool graphVisibility = false, removeOldData = false, aiImprovements = false;

  @override
  void initState() {
    aiImprovements = _settingsService.getSettingValue('ai-improvements');
    graphVisibility = _settingsService.getSettingValue('hide-graph-visibility');
    removeOldData = _settingsService.getSettingValue('remove-old-data');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
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
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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

                const SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Actions",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                const Divider(),

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
                      confirm: () {
                        TrackerService().clearData();
                        Navigator.pop(context); // close the dialog
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Options",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                const Divider(),

                // Toggle AI Recommendations
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        "AI Improvements",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Switch(
                      activeColor: primaryColor,
                      value: aiImprovements,
                      onChanged: (value) {
                        setState(() {
                          _settingsService.setSettingValue(
                              'ai-improvements', value);

                          aiImprovements = value;
                        });
                      },
                    ),
                  ],
                ),

                // Hide the weekly report graph
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        "Hide weekly report graph",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Switch(
                      activeColor: primaryColor,
                      value: graphVisibility,
                      onChanged: (value) {
                        setState(() {
                          _settingsService.setSettingValue(
                              'hide-graph-visibility', value);

                          graphVisibility = value;
                        });
                      },
                    ),
                  ],
                ),

                // Remove data older than 7 days
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        "Auto-remove passed data",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Switch(
                      activeColor: primaryColor,
                      value: removeOldData,
                      onChanged: (value) {
                        setState(() {
                          _settingsService.setSettingValue(
                              'remove-old-data', value);

                          removeOldData = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
