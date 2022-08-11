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

import 'package:flutter_test/flutter_test.dart';
import 'package:zxbase_flutter_ui/zxbase_flutter_ui.dart';

void main() {
  test('time', () async {
    DateTime test = DateTime.utc(2022, 08, 09);
    expect(HumanTime.time(test), equals('12:00 AM'));
  });

  test('date', () async {
    DateTime test = DateTime.utc(2021, 08, 09);
    expect(HumanTime.date(test), equals('Monday, August 9, 2021'));
  });

  test('short date', () async {
    DateTime test = DateTime.utc(2021, 08, 09);
    expect(HumanTime.shortDate(test), equals('August 9, 2021'));
  });

  test('date time', () async {
    DateTime test = DateTime.utc(2021, 08, 09);
    expect(
        HumanTime.dateTime(test), equals('Monday, August 9, 2021 at 12:00 AM'));
  });

  test('last seen', () async {
    DateTime today = DateTime.now();
    expect(HumanTime.lastSeen(today.subtract(const Duration(hours: 1))),
        equals('about an hour ago'));
  });

  test('last seen from timestamp', () async {
    DateTime today = DateTime.now();
    int ts = today.millisecondsSinceEpoch;
    expect(HumanTime.lastSeenFromTS(ts - 3600000), equals('about an hour ago'));
  });

  test('short date time from timestamp', () async {
    int ts = 3500000;
    // provide UTC and not UTC time for different test systems
    var results = ['January 1, 1970 12:58 AM', 'December 31, 1969 04:58 PM'];
    expect(results.contains(HumanTime.shortDateTimeFromTS(ts)), equals(true));
  });
}
