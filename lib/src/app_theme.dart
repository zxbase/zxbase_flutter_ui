// Copyright (C) 2022 Zxbase, LLC. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Theme helpers.
/// Support light and dark theme.

library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zxbase_flutter_ui/zxbase_flutter_ui.dart';

class AppTheme {
  static const light = 'light';
  static const dark = 'dark';

  static ThemeData _buildDarkTheme({bool useMaterial3 = false}) {
    final ThemeData base = ThemeData.dark(useMaterial3: useMaterial3);

    return base.copyWith(
      appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white),
    );
  }

  static ThemeData _buildLightTheme({bool useMaterial3 = false}) {
    final ThemeData base = ThemeData.light(useMaterial3: useMaterial3);

    return base.copyWith(
        appBarTheme: base.appBarTheme.copyWith(
            color: UI.isMobile ? Colors.grey.shade100 : Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.black),
        bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
            backgroundColor:
                UI.isMobile ? Colors.grey.shade100 : Colors.transparent));
  }

  static setOverlayStyle(String themeName) {
    var style = (themeName == dark)
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  static build(String themeName) {
    return (themeName == dark) ? _buildDarkTheme() : _buildLightTheme();
  }
}
