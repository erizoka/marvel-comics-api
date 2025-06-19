import 'package:flutter/material.dart';

class DetailScreenButton extends StatelessWidget {
  final void Function() onPressed;
  final bool isSelectecd;
  final IconData icon;
  final String title;
  final double? fontSize;
  const DetailScreenButton({
    super.key,
    required this.onPressed,
    required this.isSelectecd,
    required this.icon,
    required this.title,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Theme.of(context).colorScheme.tertiary,
        size: isSelectecd ? 30 : 35,
      ),
      label:
          isSelectecd
              ? Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: fontSize,
                ),
              )
              : const SizedBox.shrink(),
    );
  }
}
