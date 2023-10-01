import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayContainer extends StatelessWidget {
  final String id;
  final String details;
  final int score;

  const DayContainer({
    super.key,
    required this.id,
    required this.details,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 2,
                  height: 25,
                  color: Theme.of(context).colorScheme.primary,
                ), // color based on mood
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat("EEEE").format(DateTime.parse(id)),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            DateFormat("MMM dd, yyyy")
                                .format(DateTime.parse(id)),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
