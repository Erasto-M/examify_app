import 'package:flutter_test/flutter_test.dart';
import 'package:examify/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ProfileItemModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
