// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/color_schemes.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Mangalore Hymns',
    theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
    darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
    home: HomeScreen(),
  ));
}

