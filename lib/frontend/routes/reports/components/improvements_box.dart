import 'package:flutter/material.dart';

class ImprovementsBox extends StatelessWidget {
  const ImprovementsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Improvements",
          style: Theme.of(context).textTheme.bodyLarge,
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
            child: Text(
              "Hey, this is what you can do to improve your life:\n\n\n\n",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.info, color: Colors.red[400]),
            const SizedBox(width: 4),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
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
