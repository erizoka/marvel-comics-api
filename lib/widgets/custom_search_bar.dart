import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomSearchBar extends StatefulWidget {
  final List<String> suggestionList;
  final void Function(String) onSubmit;

  const CustomSearchBar({
    super.key,
    required this.suggestionList,
    required this.onSubmit,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late final SearchController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SearchController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      searchController: _controller,
      barHintText: 'Search..',
      barBackgroundColor: WidgetStateProperty.all(Colors.transparent),
      barTextStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
      viewHeaderTextStyle: TextStyle(color: Colors.white),
      isFullScreen: false,
      viewBackgroundColor: Colors.black,
      onSubmitted: (input) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          FocusScope.of(context).unfocus();
        });
        _controller.closeView(input);
        widget.onSubmit(input);
      },
      suggestionsBuilder: (context, controller) {
        final input = controller.text.toLowerCase();

        final filtered =
            widget.suggestionList
                .where((item) => item.toLowerCase().contains(input))
                .toList();

        return filtered.map((item) {
          return ListTile(
            title: Text(item, style: TextStyle(color: Colors.white)),
            onTap: () {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                FocusScope.of(context).unfocus();
              });
              controller.closeView(item);
              widget.onSubmit(item);
            },
          );
        }).toList();
      },
    );
  }
}
