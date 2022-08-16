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

/// TextEditingController with undo and redo functionality.
/// Includes controllers' text and selection.
/// Use save() to record current state.
/// Use undo() to go back to previously recorded state.
/// Use redo() to apply previously undone state.

import 'package:flutter/material.dart';

class LimitedStack<T> {
  LimitedStack({this.limit});

  int? limit;
  final List<T> _data = [];

  bool get isEmpty => _data.isEmpty;
  bool get isNotEmpty => _data.isNotEmpty;
  int get length => _data.length;
  T get peak => _data.last;

  void push(T item) {
    _data.add(item);
    if (limit != null && _data.length > limit!) {
      _data.removeAt(0);
    }
  }

  T pop() {
    return _data.removeLast();
  }

  void clear() {
    _data.clear();
  }
}

class StateHistory<T> {
  StateHistory({this.limit}) {
    _undoStack = LimitedStack<T>(limit: limit);
    _redoStack = LimitedStack<T>(limit: limit);
  }

  int? limit;
  late LimitedStack<T> _undoStack;
  late LimitedStack<T> _redoStack;

  bool get canUndo => _undoStack.length > 1;
  bool get canRedo => _redoStack.isNotEmpty;

  void update(T item) {
    _undoStack.push(item);
    _redoStack.clear();
  }

  T undo() {
    T curr = _undoStack.pop();
    _redoStack.push(curr);

    return _undoStack.peak;
  }

  T redo() {
    T rv = _redoStack.pop();
    _undoStack.push(rv);

    return rv;
  }
}

class ControllerState {
  ControllerState({required this.text, required this.selection});

  final String text;
  final TextSelection selection;
}

class HistoryController extends TextEditingController {
  HistoryController({this.limit = 20}) : super() {
    stateHistory = StateHistory(limit: limit);
  }

  int limit;
  late StateHistory stateHistory;

  // record the current state
  save() {
    stateHistory.update(ControllerState(text: text, selection: selection));
  }

  undo() {
    if (!stateHistory.canUndo) {
      return;
    }
    ControllerState item = stateHistory.undo();
    text = item.text;
    selection = item.selection;
  }

  redo() {
    if (!stateHistory.canRedo) {
      return;
    }
    ControllerState item = stateHistory.redo();
    text = item.text;
    selection = item.selection;
  }
}
