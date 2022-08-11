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

import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class HumanTime {
  /// 12:00 AM
  static String time(DateTime date) {
    return DateFormat('hh:mm a').format(date).toString();
  }

  /// Current year: Tuesday, August 9
  /// Previous years: Monday, August 9, 2021
  static String date(DateTime date) {
    String rv = DateFormat.MMMMEEEEd().format(date);

    if (DateTime.now().year != date.year) {
      rv += ', ${date.year}';
    }

    return rv;
  }

  /// Current year: August 9
  /// Previous years: August 9, 2021
  static String shortDate(DateTime date) {
    String rv = DateFormat.MMMMd().format(date);

    if (DateTime.now().year != date.year) {
      rv += ', ${date.year}';
    }

    return rv;
  }

  /// Current year: Tuesday, August 9 12:00 AM
  /// Previous years: Monday, August 9, 2021 12:00 AM
  static String dateTime(DateTime dateTime) {
    return '${date(dateTime)} at ${time(dateTime)}';
  }

  /// Current year: August 9 12:00 AM
  /// Previous years: January 1, 1970 12:58 AM
  static String shortDateTimeFromTS(int ts) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(ts);
    return '${shortDate(dt)} ${time(dt)}';
  }

  /// 'about an hour ago'
  static String lastSeen(DateTime date) {
    return timeago.format(date);
  }

  /// 'about an hour ago'
  static String lastSeenFromTS(int ts) {
    return timeago.format(DateTime.fromMillisecondsSinceEpoch(ts));
  }
}
