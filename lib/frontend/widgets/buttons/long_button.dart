import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Function? onTap;
  final Color color;
  final bool isFirst;
  final bool isLast;

  const LongButton({
    super.key,
    required this.title,
    this.onTap,
    required this.trailing,
    required this.color,
    this.isFirst = false,
    this.isLast = false,
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(isFirst ? 12 : 4),
        topRight: Radius.circular(isFirst ? 12 : 4),
        bottomLeft: Radius.circular(isLast ? 12 : 4),
        bottomRight: Radius.circular(isLast ? 12 : 4),
      )),
    );
  }
}
