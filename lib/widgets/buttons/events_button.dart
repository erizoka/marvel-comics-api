import 'package:flutter/material.dart';

class EventsButton extends StatelessWidget {
  final void Function() onPressed;
  final bool isSelectecd;
  const EventsButton({
    super.key,
    required this.onPressed,
    required this.isSelectecd,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        Icons.calendar_month,
        color: Theme.of(context).colorScheme.tertiary,
        size: isSelectecd ? 30 : 35,
      ),
      label:
          isSelectecd
              ? Text(
                "Events",
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              )
              : const SizedBox.shrink(),
    );
  }
}
