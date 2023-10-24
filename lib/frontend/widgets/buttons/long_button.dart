import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Function? onTap;
  final Color color;

  const LongButton({
    super.key,
    required this.title,
    this.onTap,
    required this.trailing,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: trailing,
      onTap: () => onTap!(),
      tileColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }
}
