import 'package:flutter_test/flutter_test.dart';
import 'package:examify/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('AdminDashboardServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
