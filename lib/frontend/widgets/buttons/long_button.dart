import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function? onTap;

  const LongButton(
      {super.key, required this.title, this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.75,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        trailing: Icon(
          icon,
          size: 24,
          color: Colors.white,
        ),
        onTap: () => onTap!(),
        tileColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
