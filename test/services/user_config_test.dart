import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker/services/user_config.dart'; // Update with actual package path

void main() {
  group('UserConfig', () {
    test('photoUrl should return the correct URL', () {
      final userConfig = UserConfig();

      // Expected URL
      const expectedUrl = 'https://avatars.githubusercontent.com/u/120930148?v=4';

      // Check if the photoUrl matches the expected URL
      expect(userConfig.photoUrl, expectedUrl);
    });
  });
}
