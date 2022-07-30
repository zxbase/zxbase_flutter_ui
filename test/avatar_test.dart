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
