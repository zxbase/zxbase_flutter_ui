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
import 'package:flutter_test/flutter_test.dart';
import 'package:zxbase_flutter_ui/zxbase_flutter_ui.dart';

TextSelection dts = const TextSelection(baseOffset: 0, extentOffset: 0);

void main() {
  test('Limited stack', () async {
    LimitedStack undo = LimitedStack(limit: 3);

    expect(undo.isEmpty, equals(true));
    expect(undo.isNotEmpty, equals(false));

    undo.push(ControllerState(text: 'a', selection: dts));
    expect(undo.isNotEmpty, equals(true));
    undo.push(ControllerState(text: 'aa', selection: dts));
    undo.push(ControllerState(text: 'aaa', selection: dts));
    expect(undo.length, equals(3));
    // ignore: avoid_dynamic_calls
    expect(undo.peak.text, equals('aaa'));

    undo.push(ControllerState(text: 'aaaa', selection: dts));
    expect(undo.length, equals(3));

    // ignore: avoid_dynamic_calls
    expect(undo.pop()!.text, equals('aaaa'));
    // ignore: avoid_dynamic_calls
    expect(undo.pop()!.text, equals('aaa'));
    // ignore: avoid_dynamic_calls
    expect(undo.pop()!.text, equals('aa'));
    expect(undo.length, equals(0));
    expect(undo.isEmpty, equals(true));

    undo.push(ControllerState(text: 'bbb', selection: dts));
    expect(undo.length, equals(1));
    expect(undo.isNotEmpty, equals(true));
    // ignore: avoid_dynamic_calls
    expect(undo.pop()!.text, equals('bbb'));

    undo.clear();
    expect(undo.length, equals(0));
  });

  test('Undo redo', () async {
    ControllerState item = ControllerState(text: 'original', selection: dts);
    StateHistory undoRedo = StateHistory(limit: 3);
    undoRedo.update(item);

    expect(undoRedo.canUndo, equals(false));
    expect(undoRedo.canRedo, equals(false));
    undoRedo.update(ControllerState(text: 'a', selection: dts));
    expect(undoRedo.canUndo, equals(true));
    expect(undoRedo.canRedo, equals(false));

    // ignore: avoid_dynamic_calls
    expect(undoRedo.undo()!.text, equals('original'));
    expect(undoRedo.canUndo, equals(false));
    expect(undoRedo.canRedo, equals(true));

    // ignore: avoid_dynamic_calls
    expect(undoRedo.redo()!.text, equals('a'));
    expect(undoRedo.canUndo, equals(true));
    expect(undoRedo.canRedo, equals(false));

    undoRedo.update(ControllerState(text: 'b', selection: dts));
    expect(undoRedo.canRedo, equals(false));
    undoRedo.update(ControllerState(text: 'c', selection: dts));
    undoRedo.update(ControllerState(text: 'd', selection: dts));
    undoRedo.update(ControllerState(text: 'e', selection: dts));
    undoRedo.update(ControllerState(text: 'f', selection: dts));
    expect(undoRedo.canRedo, equals(false));

    expect(undoRedo.canUndo, equals(true));
    // ignore: avoid_dynamic_calls
    expect(undoRedo.undo()!.text, equals('e'));
    expect(undoRedo.canUndo, equals(true));
    // ignore: avoid_dynamic_calls
    expect(undoRedo.undo()!.text, equals('d'));
    expect(undoRedo.canUndo, equals(false));

    expect(undoRedo.canRedo, equals(true));
    // ignore: avoid_dynamic_calls
    expect(undoRedo.redo()!.text, equals('e'));
    expect(undoRedo.canRedo, equals(true));
    // ignore: avoid_dynamic_calls
    expect(undoRedo.redo()!.text, equals('f'));
    expect(undoRedo.canRedo, equals(false));

    undoRedo.update(ControllerState(text: '1', selection: dts));
    undoRedo.undo();
    undoRedo.update(ControllerState(text: '2', selection: dts));
    expect(undoRedo.canRedo, equals(false));
  });

  test('Undo history controller', () async {
    HistoryController historyController = HistoryController(limit: 5);

    historyController.text = 'x';
    expect(historyController.text, equals('x'));

    historyController.save();
    expect(historyController.text, equals('x'));

    historyController.text = 'y';
    historyController.save();

    historyController.undo();
    expect(historyController.text, equals('x'));

    historyController.redo();
    expect(historyController.text, equals('y'));
  });
}
