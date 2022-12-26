
import 'package:flutter/material.dart';

const List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: "Text",
    icon: Icon(Icons.article_outlined),
    label: 'Text',
    selectedIcon: Icon(Icons.article),
  ),
  NavigationDestination(
    tooltip: "Notation",
    icon: Icon(Icons.music_note_outlined),
    label: 'Notation',
    selectedIcon: Icon(Icons.music_note),
  ),
  NavigationDestination(
    tooltip: "Alphabet",
    icon: Icon(Icons.sort_by_alpha_outlined),
    label: 'Alphabet',
    selectedIcon: Icon(Icons.sort_by_alpha),
  ),
  NavigationDestination(
    tooltip: "Category",
    icon: Icon(Icons.category_outlined),
    label: 'Category',
    selectedIcon: Icon(Icons.category),
  ),
];

class NavigationBars extends StatefulWidget {
  final void Function(int)? onSelectItem;
  final int selectedIndex;

  const NavigationBars(
      {super.key, this.onSelectItem, required this.selectedIndex});

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
          print(index);
        });
        widget.onSelectItem!(index);
      },
      destinations: appBarDestinations,
    );
  }
}
