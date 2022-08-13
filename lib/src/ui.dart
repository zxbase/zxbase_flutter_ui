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

class UI {
  /// System.
  static final bool isDesktop =
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  static final bool isMobile = Platform.isIOS || Platform.isAndroid;

  /// Fonts.
  static final double fontSizeXSmall = isDesktop ? 10 : 12;
  static final double fontSizeSmall = isDesktop ? 12 : 14;
  static final double fontSizeMedium = isDesktop ? 14 : 16;
  static final double fontSizeLarge = isDesktop ? 18 : 20;

  /// Misc.
  static const double badgeSize = 10;
}
