import 'package:flutter/material.dart';

class EventsButton extends StatelessWidget {
  const EventsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.calendar_month,
        color: Theme.of(context).colorScheme.tertiary,
        size: 35,
      ),
    );
  }
}
