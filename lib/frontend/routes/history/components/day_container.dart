// Generic imports
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DayContainer extends StatelessWidget {
  final String id;
  final String details;
  final String feeling;
  final int score;

  const DayContainer({
    super.key,
    required this.id,
    required this.details,
    required this.score,
    required this.feeling,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
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
                  Column(
                    children: [
                      Container(
                        width: 2,
                        height: 17.5,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        radius: 3,
                      ),
                      Container(
                        width: 2,
                        height: 17.5,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    DateFormat("EEEE")
                                        .format(DateTime.parse(id)),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    DateFormat("MMM dd, yyyy")
                                        .format(DateTime.parse(id)),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 2,
                          height: 45,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$feeling (+$score)",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                              ),
                            ),
                            if (details.isNotEmpty)
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.15,
                                child: Text(
                                  details,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
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
      ),
    );
  }
}
