import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;
  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon:
          isFavorite
              ? Icon(
                Icons.star,
                color: Theme.of(context).colorScheme.tertiary,
                size: 35,
              )
              : Icon(
                Icons.star_border,
                color: Theme.of(context).colorScheme.tertiary,
                size: 35,
              ),
    );
  }
}
