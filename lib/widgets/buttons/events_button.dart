import 'package:flutter/material.dart';

class EventsButton extends StatelessWidget {
  final void Function() onPressed;
  const EventsButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.calendar_month,
        color: Theme.of(context).colorScheme.tertiary,
        size: 35,
      ),
    );
  }
}
