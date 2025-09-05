import 'package:flutter_test/flutter_test.dart';
import 'package:language_translator/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('HiveServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
