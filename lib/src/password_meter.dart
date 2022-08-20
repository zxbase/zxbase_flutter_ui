import 'package:flutter/material.dart';
import 'package:zxbase_flutter_ui/zxbase_flutter_ui.dart';

/// Password meter with a progress bar.
/// Based on password score in the range [0,4] and length.

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

  static Widget caption(int index) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        textAlign: TextAlign.start,
        'Password strength:',
        style: TextStyle(fontSize: UI.fontSizeMedium),
      ),
      Text(
        textAlign: TextAlign.end,
        _caption[index],
        style: TextStyle(color: _color[index], fontSize: UI.fontSizeMedium),
      ),
    ]);
  }

  static Widget full({required double score, required bool isEmpty}) {
    final index = isEmpty ? 0 : score.floor() + 1;
    return Column(children: [
      caption(index),
      Padding(
          padding: const EdgeInsets.only(top: 10), child: discreteBar(index)),
    ]);
  }
}
