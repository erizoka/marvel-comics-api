import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final List<String> suggestionList;
  final void Function(String) onSubmit;

  const CustomSearchBar({
    super.key,
    required this.suggestionList,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      barHintText: 'Search..',
      barBackgroundColor: WidgetStateProperty.all(Colors.transparent),
      isFullScreen: false,
      viewBackgroundColor: Colors.black,
      suggestionsBuilder: (context, controller) {
        final input = controller.text.toLowerCase();

        final filtered =
            suggestionList
                .where((item) => item.toLowerCase().contains(input))
                .toList();

        return filtered.map((item) {
          return ListTile(
            title: Text(item, style: TextStyle(color: Colors.white)),
            onTap: () {
              controller.closeView(item);
              onSubmit(item);
            },
          );
        }).toList();
      },
    );
  }
}
