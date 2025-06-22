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

import 'dart:io';
import 'package:flutter/material.dart';

class UI {
  /// System.
  static final bool isMobile = Platform.isIOS || Platform.isAndroid;
  static bool isDesktop = !isMobile;
  static bool testEnvironment =
      Platform.environment.containsKey('FLUTTER_TEST');

  /// Fonts.
  static final double fontSizeXSmall = isDesktop ? 10 : 12;
  static final double fontSizeSmall = isDesktop ? 12 : 14;
  static final double fontSizeMedium = isDesktop ? 14 : 16;
  static final double fontSizeLarge = isDesktop ? 18 : 20;

  /// Misc constants.
  static const double badgeSize = 10;
  static final double appBarTextFactor = isMobile ? 1.3 : 1.4;
  static final double appBarLeadWidth = isMobile ? 82 : 74;

  /// Helpers.
  static TextStyle highlightedTextStyle =
      const TextStyle(color: Colors.black, backgroundColor: Colors.yellow);

  static TextStyle urlStyle = const TextStyle(
    color: Colors.blueAccent,
    decoration: TextDecoration.underline,
  );

  static double? listTitleFontSize(BuildContext context) {
    return isDesktop
        ? Theme.of(context).textTheme.bodyMedium!.fontSize
        : Theme.of(context).textTheme.titleMedium!.fontSize;
  }

  static double? listSubtitleFontSize(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!.fontSize;
  }

  static TextStyle listTrailingTextStyle(
      BuildContext context, bool isSelected) {
    TextStyle style = TextStyle(fontSize: UI.fontSizeSmall);
    if (isSelected) {
      return style;
    }
    return style
        .merge(TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!));
  }

  static void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
    ));
  }
}
