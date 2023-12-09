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

/// Date and time representation UI.

library;

import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class HumanTime {
  /// 12:00 AM
  static String time(DateTime dt) {
    return DateFormat('hh:mm a').format(dt).toString();
  }

  /// Current year: Tuesday, August 9
  /// Previous years: Monday, August 9, 2021
  static String date(DateTime dt) {
    String rv = DateFormat.MMMMEEEEd().format(dt);

    if (DateTime.now().year != dt.year) {
      rv += ', ${dt.year}';
    }

    return rv;
  }

  /// Current year: August 9
  /// Previous years: August 9, 2021
  static String shortDate(DateTime dt) {
    String rv = DateFormat.MMMMd().format(dt);

    if (DateTime.now().year != dt.year) {
      rv += ', ${dt.year}';
    }

    return rv;
  }

  /// Current year: Tuesday, August 9 12:00 AM
  /// Previous years: Monday, August 9, 2021 12:00 AM
  static String dateTime(DateTime dt) {
    return '${date(dt)} at ${time(dt)}';
  }

  /// Current year: August 9 12:00 AM
  /// Previous years: January 1, 1970 12:58 AM
  static String shortDateTimeFromTS(int ts) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(ts);
    return '${shortDate(dt)} ${time(dt)}';
  }

  /// 'about an hour ago'
  static String lastSeen(DateTime dt) {
    return timeago.format(dt);
  }

  /// 'about an hour ago'
  static String lastSeenFromTS(int ts) {
    return timeago.format(DateTime.fromMillisecondsSinceEpoch(ts));
  }

  /// PDT (-7)
  static String tz(DateTime dt) {
    return '${dt.timeZoneName} (${dt.timeZoneOffset.inHours})';
  }

  static bool isToday(DateTime dt) {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day) ==
        DateTime(dt.year, dt.month, dt.day);
  }

  /// Today: 12:00:00 AM
  /// This year: August 9 12:00:00 AM
  /// Previous years: August 9, 2021 12:00:00 AM
  static String preciseTime(DateTime dt) {
    String time = DateFormat('hh:mm:ss a').format(dt).toString();

    if (isToday(dt)) {
      return time;
    } else {
      return '${shortDate(dt)} $time';
    }
  }
}
