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

void main() {
  test('Detect desktop vs mobile', () {
    expect(UI.isDesktop, true);
    expect(UI.isMobile, false);
  });

  test('Font sizes', () {
    expect(UI.fontSizeXSmall, 10);
    expect(UI.fontSizeSmall, 12);
    expect(UI.fontSizeMedium, 14);
    expect(UI.fontSizeLarge, 18);
  });

  test('Misc constants', () {
    expect(UI.appBarTextFactor, 1.4);
    expect(UI.appBarLeadWidth, 74);
  });

  test('Text styles', () {
    MockBuildContext mockContext = MockBuildContext();
    expect(UI.highlightedTextStyle.backgroundColor, Colors.yellow);
    expect(UI.urlStyle.color, Colors.blueAccent);
    expect(UI.listTitleFontSize(mockContext), 14);
    expect(UI.listSubtitleFontSize(mockContext), 14);
    expect(UI.listTrailingTextStyle(mockContext, true).color, null);
    expect(UI.listTrailingTextStyle(mockContext, false).color, Colors.black54);

    UI.isDesktop = false;
    expect(UI.listTitleFontSize(mockContext), 16);
    expect(UI.testEnvironment, true);
  });

  testWidgets('Snack bar', (WidgetTester tester) async {
    const String text = 'Hi';
    const Key tapTarget = Key('tap-target');
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              UI.showSnackbar(context, text);
            },
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(
              height: 100.0,
              width: 100.0,
              key: tapTarget,
            ),
          );
        }),
      ),
    ));
    expect(find.text(text), findsNothing);
    await tester.tap(find.byKey(tapTarget), warnIfMissed: false);
    expect(find.text(text), findsNothing);
    await tester.pump(); // schedule animation
    expect(find.text(text), findsOneWidget);
  });
}
