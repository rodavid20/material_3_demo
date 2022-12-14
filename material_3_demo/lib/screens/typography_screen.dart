// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../models/hymn.dart';
class TypographyScreen extends StatefulWidget {
  TypographyScreen({Key? key}) : super(key: key);

  @override
  State<TypographyScreen> createState() => _TypographyScreenState();

}
//https://pub.dev/packages/material_segmented_control/example

class _TypographyScreenState extends State<TypographyScreen> {
  int _currentSelection = 0;
  Map<int, Widget> _choicesList = {
    0: Text('Kan'),
    1: Text('Tulu')
  };

  // Holds all indices of children to be disabled.
  // Set this list either null or empty to have no children disabled.
  List<int> _disabledIndices = [];

  @override
  void initState() {
    super.initState();
    _currentSelection = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          ListView.builder(
              itemCount: Hymn.hymns.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          // TODO: Replace return with return RecipeDetail()
                          return Text('Detail page');
                        },
                      ),
                    );
                  },
                  child: buildHymnCard(Hymn.hymns[index]),
                );
              }
          ),
    );
  }

  Widget buildHymnCard(Hymn hymn) {
    return ListTile(
        leading: Text(hymn.number),
        title: Text(hymn.kanTitle));
  }
}
