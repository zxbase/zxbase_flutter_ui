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

/// Password meter with a progress bar.
/// Based on password score in the range [0,4] and length.

import 'package:flutter/material.dart';

class PasswordMeter {
  static final _caption = ['', 'Very weak', 'Weak', 'Fair', 'Good', 'Strong'];

  static final _color = [
    Colors.grey,
    Colors.red,
    Colors.orange,
    Colors.yellow[600],
    Colors.blue,
    Colors.green
  ];

  static Widget discreteBar(int index) {
    return LinearProgressIndicator(
        value: index / (_color.length - 1),
        color: _color[index],
        minHeight: 5,
        backgroundColor: Colors.grey);
  }

  static Widget caption(int index, BuildContext context) {
    TextStyle captionStyle = Theme.of(context)
        .textTheme
        .bodySmall!
        .copyWith(color: Theme.of(context).hintColor);
    TextStyle assessmentStyle =
        Theme.of(context).textTheme.titleSmall!.copyWith(color: _color[index]);

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        textAlign: TextAlign.start,
        'Password strength',
        style: captionStyle,
      ),
      Text(
        textAlign: TextAlign.end,
        _caption[index],
        style: assessmentStyle,
      ),
    ]);
  }

  static Widget full(
      {required double score,
      required bool isEmpty,
      required BuildContext context}) {
    final index = isEmpty ? 0 : score.floor() + 1;
    return Column(children: [
      caption(index, context),
      Padding(
          padding: const EdgeInsets.only(top: 5), child: discreteBar(index)),
    ]);
  }
}
