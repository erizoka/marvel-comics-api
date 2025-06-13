import 'package:flutter/material.dart';

class CharactersButton extends StatelessWidget {
  final void Function() onPressed;
  final bool isSelectecd;
  const CharactersButton({
    super.key,
    required this.onPressed,
    required this.isSelectecd,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        Icons.people,
        color: Theme.of(context).colorScheme.tertiary,
        size: isSelectecd ? 27 : 35,
      ),
      label:
          isSelectecd
              ? Text(
                "Characters",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 14,
                ),
              )
              : const SizedBox.shrink(),
    );
  }
}
