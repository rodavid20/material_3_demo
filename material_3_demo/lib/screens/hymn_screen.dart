// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import '../models/hymn.dart';

class HymnScreen extends StatefulWidget {
  const HymnScreen({Key? key}) : super(key: key);

  @override
  State<HymnScreen> createState() => _HymnScreenState();
}

class _HymnScreenState extends State<HymnScreen> {
  int screenIndex = 0;
  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: GestureDetector(
                onScaleStart: (details) {
                  _baseScaleFactor = _scaleFactor;
                },
                onScaleUpdate: (details) {
                  setState(() {
                    _scaleFactor = _baseScaleFactor * details.scale;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    Hymn.hymns[0].kanText,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 20),
                    //change to fontsize increase instead of scale.
                    //check zoom does not work on blank space  when hymn  with few lines
                    textScaleFactor: _scaleFactor,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }
}

void Function()? handlePressed(
    BuildContext context, bool isDisabled, String buttonName) {
  return isDisabled
      ? null
      : () {
          final snackBar = SnackBar(
            content: Text(
              'Yay! $buttonName is clicked!',
              style: TextStyle(color: Theme.of(context).colorScheme.surface),
            ),
            action: SnackBarAction(
              textColor: Theme.of(context).colorScheme.surface,
              label: 'Close',
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        };
}
