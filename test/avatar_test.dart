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

void main() {
  test('Build my avatar', () {
    final peerAvatar = Avatar.me();
    expect(peerAvatar.name, null);
  });

  test('Build peer avatar', () {
    const name = 'Samuel Adams';
    final peerAvatar = Avatar.peer(name: name, status: AvatarStatus.online);
    expect(peerAvatar.name, name);
    expect(peerAvatar.children.length, 2);
    expect(peerAvatar.decoration!.color, Colors.cyan);
    expect(peerAvatar.children[0].runtimeType, Container);
  });

  test('Build peer avatar with unread badge', () {
    const name = 'Samuel Adams';
    final peerAvatar =
        Avatar.peer(name: name, status: AvatarStatus.online, unread: 1);
    expect(peerAvatar.name, name);
    expect(peerAvatar.children.length, 2);
    expect(peerAvatar.children[0].runtimeType, Align);
  });

  test('Build peer avatar with an empty name', () {
    const name = '    ';
    final peerAvatar = Avatar.peer(name: name, status: AvatarStatus.online);
    expect(peerAvatar.name, 'John Doe');
    expect(peerAvatar.children.length, 2);
    expect(peerAvatar.decoration!.color, Colors.red);
    expect(peerAvatar.children[0].runtimeType, Container);
  });

  test('Build peer avatar with a name with spaces', () {
    const name = '   Samuel           Adams   ';
    final peerAvatar = Avatar.peer(name: name, status: AvatarStatus.online);
    expect(peerAvatar.name, name);
    expect(peerAvatar.children.length, 2);
    expect(peerAvatar.decoration!.color, Colors.cyan);
    expect(peerAvatar.children[0].runtimeType, Container);
  });

  test('Build peer avatar with a name with special characters', () {
    const name = '   @#\$%^&*&&^%#@           !@#%   ';
    final peerAvatar = Avatar.peer(name: name, status: AvatarStatus.online);
    expect(peerAvatar.name, name);
    expect(peerAvatar.children.length, 2);
    expect(peerAvatar.decoration!.color, Colors.purple);
    expect(peerAvatar.children[0].runtimeType, Container);
  });
}
