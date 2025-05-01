import 'package:flutter/material.dart';
import 'package:standard_searchbar/new/standard_search_anchor.dart';
import 'package:standard_searchbar/new/standard_search_bar.dart';
import 'package:standard_searchbar/new/standard_suggestion.dart';
import 'package:standard_searchbar/new/standard_suggestions.dart';

class CustomSearchBar extends StatelessWidget {
  final List<String> suggestionList;
  const CustomSearchBar({super.key, required this.suggestionList});

  @override
  Widget build(BuildContext context) {
    return StandardSearchAnchor(
      searchBar: StandardSearchBar(bgColor: Colors.black),
      suggestions: StandardSuggestions(
        suggestions: List.generate(5, (_) {
          for (var s in suggestionList) {
            return StandardSuggestion(text: s);
          }
          return StandardSuggestion(text: '');
        }),
      ),
    );
  }
}
