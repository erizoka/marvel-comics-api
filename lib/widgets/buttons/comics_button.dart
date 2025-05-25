import 'package:flutter/material.dart';

class ComicsButton extends StatelessWidget {
  final void Function() onPressed;
  const ComicsButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.menu_book_sharp,
        color: Theme.of(context).colorScheme.tertiary,
        size: 35,
      ),
    );
  }
}
