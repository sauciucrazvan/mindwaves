// Generic imports
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Backend imports
import 'package:mindwaves/backend/services/tracker_service.dart';
import 'package:mindwaves/backend/services/settings_service.dart';
import 'package:mindwaves/backend/services/notification_service.dart';

// Frontend imports
import 'package:mindwaves/frontend/widgets/buttons/leading_button.dart';
import 'package:mindwaves/frontend/widgets/buttons/long_button.dart';
import 'package:mindwaves/frontend/widgets/buttons/small_button.dart';
import 'package:mindwaves/frontend/widgets/dialogs/confirm_dialog.dart';
import 'package:mindwaves/frontend/widgets/notifications/elevated_notification.dart';

class SettingsPanel extends StatefulWidget {
  const SettingsPanel({super.key});

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  final SettingsService _settingsService = SettingsService();

  bool graphVisibility = false,
      removeOldData = false,
      aiImprovements = false,
      disableNotifications = false,
      informativeMessages = false;

  @override
  void initState() {
    aiImprovements = _settingsService.getSettingValue('ai-improvements');
    graphVisibility = _settingsService.getSettingValue('hide-graph-visibility');
    removeOldData = _settingsService.getSettingValue('remove-old-data');
    informativeMessages =
        _settingsService.getSettingValue('disable-informative-messages');
    disableNotifications =
        _settingsService.getSettingValue('disable-notifications');
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
                  "Settings Panel",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Options",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Lottie.asset(
                      "assets/animations/options.json",
                      width: 32,
                      height: 32,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AI Improvements",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 2),
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

                // Disable informative messages
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        "Disable informative messages",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Switch(
                      activeColor: primaryColor,
                      value: informativeMessages,
                      onChanged: (value) {
                        setState(() {
                          _settingsService.setSettingValue(
                              'disable-informative-messages', value);

                          informativeMessages = value;
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

                // Send reminders
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Disable reminders",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "Reminders only work if you\nrun your app in the background.",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      activeColor: primaryColor,
                      value: disableNotifications,
                      onChanged: (value) {
                        setState(() {
                          _settingsService.setSettingValue(
                              'disable-notifications', value);

                          disableNotifications = value;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Notification time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        "Send notification at",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          NotificationService().getNotificationTime(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SmallButton(
                          icon: Icons.timer,
                          color: Theme.of(context).colorScheme.primary,
                          pressed: () async {
                            TimeOfDay? selectedTime =
                                await _settingsService.timePicker(context);

                            if (selectedTime == null) return;

                            setState(() {
                              _settingsService.setSettingValue(
                                  "notification-time", {
                                "hour": selectedTime.hour.toString(),
                                "minute": selectedTime.minute.toString()
                              });
                            });

                            // ignore: use_build_context_synchronously
                            showElevatedNotification(
                              context,
                              "Value updated. Taking action on the next track of a day!",
                              Colors.lightGreen.shade700,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Actions",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Lottie.asset(
                      "assets/animations/actions.json",
                      width: 32,
                      height: 32,
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                const Divider(),

                // Clear todays data
                LongButton(
                  title: "Delete today's data",
                  trailing: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 24,
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => ConfirmDialog(
                      title:
                          "Are you sure you want to delete the track for today?",
                      confirm: () {
                        TrackerService().deleteDay();
                        Navigator.pop(context);

                        showElevatedNotification(
                          context,
                          "Action completed successfully.",
                          Colors.lightGreen.shade700,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                // Clear entire history
                LongButton(
                  title: "Clear entire history",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
