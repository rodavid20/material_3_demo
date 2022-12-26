// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:grouped_list/grouped_list.dart';

import '../models/hymn.dart';
import '../utils/hymn_changed.dart';

class HymnListScreen extends StatefulWidget {
  final String listType;
  const HymnListScreen(this.listType);

  @override
  State<HymnListScreen> createState() => _HymnListScreen();
}

class _HymnListScreen extends State<HymnListScreen> {
  Object? _currentSelection = 0;
  Map<int, Widget> _choicesList = {
    0: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text('Kannada', ),
    ),
    1: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text('Tulu'),
    ),
  };

  List<int> _disabledIndices = [];

  @override
  void initState() {
    super.initState();
    _currentSelection = 0;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: MaterialSegmentedControl(
              children: _choicesList,
              selectionIndex: _currentSelection,
              borderColor: colorScheme.outline,
              selectedColor: colorScheme.secondary,
              unselectedColor: colorScheme.onSecondary,
              borderRadius: 6.0,
              disabledChildren: _disabledIndices,
              verticalOffset: 8.0,
              onSegmentChosen: (index) {
                setState(() {
                  _currentSelection = index;
                });
              },
            ),
          ),
          GroupedListView<dynamic, String>(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            elements: Hymn.hymns,
            groupBy: (hymn) => (widget.listType == "A") ?  hymn.kanAlphabet : hymn.kanCategory,
            groupComparator: (value1, value2) => value1.compareTo(value2),
            itemComparator: (hymn1, hymn2) => hymn1.number.compareTo(hymn2.number),
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: (value) => buildGroupHeader(value),
            itemBuilder: (context, hymn) => buildHymnCard(hymn),
          ),
        ],
      ),
    );
  }

  Widget buildGroupHeader(String groupHeader) {
    return ListTile(title:
      Text(
        groupHeader,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildHymnCard(Hymn hymn) {
    return GestureDetector(
      onTap: () {
        HymnChanged(hymn.type, hymn.number).dispatch(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {              //TODO: GO to Hymn
              return Text('Detail page');
            },
          ),
        );
      },
      child: ListTile(leading: Text((hymn.number).toString()), title: Text(hymn.kanTitle)),
    );
  }
}
