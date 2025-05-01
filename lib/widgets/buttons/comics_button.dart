import 'package:flutter/material.dart';

class ComicsButton extends StatelessWidget {
  const ComicsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.menu_book_sharp,
        color: Theme.of(context).colorScheme.tertiary,
        size: 35,
      ),
    );
  }
}
