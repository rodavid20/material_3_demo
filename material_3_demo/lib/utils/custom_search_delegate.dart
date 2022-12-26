import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = ['Apple', 'Banana', 'Pear'];
  List<String> searchTypes = ['Kan', 'Tulu', 'MT'];

  @override
  String get searchFieldLabel => 'Search hymn';

  String selectedType = 'Kan';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            close(context, null);
          },
        ),
        DropdownButton(
          value: selectedType,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: searchTypes.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            selectedType = newValue!;
          },
        ),
      ],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var hymn in searchTerms) {
      if (hymn.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(hymn);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(title: Text(result));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var hymn in searchTerms) {
      if (hymn.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(hymn);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(title: Text(result));
      },
    );
  }
}
