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

import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
// ignore: implementation_imports
import 'package:flutter_advanced_avatar/src/string_extension.dart';
import 'package:zxbase_flutter_ui/src/ui.dart';

enum AvatarStatus { unknown, offline, online }

class Avatar {
  static const String logo = 'assets/images/wt_32.png';

  static const List<Color> _colors = [
    Colors.pink,
    Colors.cyan,
    Colors.red,
    Colors.teal,
    Colors.lime,
    Colors.indigo,
    Colors.purple
  ];

  static final Map<AvatarStatus, Color> _statusColor = {
    AvatarStatus.unknown: Colors.black,
    AvatarStatus.offline: Colors.white,
    AvatarStatus.online: Colors.green.shade600
  };

  static const Map<AvatarStatus, Color> _borderColor = {
    AvatarStatus.unknown: Colors.white,
    AvatarStatus.offline: Colors.grey,
    AvatarStatus.online: Colors.white
  };

  static AdvancedAvatar me({double size = 40}) {
    const avatarColor = Color(0xFF2196F3);

    return AdvancedAvatar(
      size: size,
      image: const AssetImage(logo),
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: avatarColor,
          gradient: LinearGradient(
            colors: [
              Colors.white,
              avatarColor,
            ],
            begin: Alignment(-3.0, -3.0),
            end: Alignment(0.0, 0.0),
          )),
    );
  }

  static AdvancedAvatar peer(
      {required String name,
      required AvatarStatus status,
      int unread = 0,
      double size = 40,
      double fontSize = 18,
      double statusSize = UI.badgeSize}) {
    if (name.trim() == '') {
      name = 'John Doe';
    }

    final abbreviation = name.toAbbreviation();
    final code = abbreviation.codeUnits.reduce((a, b) => a + b);
    final avatarColor = _colors[code % _colors.length];

    return AdvancedAvatar(
        name: name,
        size: size,
        style: TextStyle(fontSize: fontSize),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: avatarColor,
            gradient: LinearGradient(
              colors: [
                Colors.white,
                avatarColor,
              ],
              begin: const Alignment(-3.0, -3.0),
              end: const Alignment(0.0, 0.0),
            )),
        children: [
          (unread > 0)
              ? Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: UI.badgeSize,
                    height: UI.badgeSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 0.5,
                      ),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.red,
                        ],
                        begin: Alignment(-2.5, -2.5),
                        end: Alignment(0.0, 0.0),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ))
              : Container(),
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: statusSize,
                height: statusSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _borderColor[status]!,
                    width: 0.5,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      _statusColor[status]!,
                    ],
                    begin: const Alignment(-2.5, -2.5),
                    end: const Alignment(0.0, 0.0),
                  ),
                  shape: BoxShape.circle,
                ),
              )),
        ]);
  }
}
