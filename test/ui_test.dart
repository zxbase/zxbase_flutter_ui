import 'package:flutter_test/flutter_test.dart';
import 'package:zxbase_flutter_ui/zxbase_flutter_ui.dart';

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
}
