import 'package:flutter/material.dart';

class SearchResultsList extends StatelessWidget {
  final List<String> searchResults;
  final ValueChanged<String> onTap;

  const SearchResultsList({
    Key? key,
    required this.searchResults,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        String result = searchResults[index];
        return ListTile(
          leading: const Icon(Icons.location_on, color: Colors.redAccent),
          title: Text(result),
          trailing: const Icon(Icons.directions, color: Colors.grey),
          onTap: () {
            onTap(result);
          },
        );
      },
    );
  }
}
