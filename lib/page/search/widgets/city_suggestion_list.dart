import 'package:flutter/material.dart';

class CitySuggestionList extends StatelessWidget {
  final List<Map<String, String>> suggestions;
  final void Function(String display, String api) onTap;

  const CitySuggestionList({
    Key? key,
    required this.suggestions,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion['display']!),
            onTap: () => onTap(suggestion['display']!, suggestion['api']!),
          );
        },
      ),
    );
  }
}
