// Imported from Tracely (https://github.com/sauciucrazvan/tracely)
import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final IconData icon;
  final Function? pressed;
  final Color color;
  final double sizeMultipler;

  const SmallButton({
    super.key,
    required this.icon,
    this.pressed,
    required this.color,
    this.sizeMultipler = 2,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => pressed!(),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(
          horizontal: 12.0 * sizeMultipler,
          vertical: 8.0 * sizeMultipler,
        ),
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
