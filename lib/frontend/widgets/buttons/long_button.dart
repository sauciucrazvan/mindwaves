import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function? onTap;
  final Color color;

  const LongButton({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
      tileColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }
}
