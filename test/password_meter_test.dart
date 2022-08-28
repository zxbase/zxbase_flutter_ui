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
import 'package:mockito/mockito.dart';
import 'package:zxbase_flutter_ui/zxbase_flutter_ui.dart';

class MockBuildContext extends Mock implements BuildContext {}

MockBuildContext mockContext = MockBuildContext();

void main() {
  testWidgets('Password meter has a caption and strength', (tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: PasswordMeter.full(
            score: 0, isEmpty: false, context: mockContext)));
    final caption = find.text('Password strength');
    final strength = find.text('Very weak');

    expect(caption, findsOneWidget);
    expect(strength, findsOneWidget);
  });

  testWidgets('Password meter has no strength', (tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child:
            PasswordMeter.full(score: 5, isEmpty: true, context: mockContext)));
    final caption = find.text('Password strength');
    final strength = find.text('');

    expect(caption, findsOneWidget);
    expect(strength, findsOneWidget);
  });
}
