import 'package:flutter/foundation.dart' show kIsWeb, TargetPlatform, defaultTargetPlatform;

class ApiConfig {
  static String baseUrl = _defaultUrl();
  static String? apiKey = 'pet-memo-flutter-key';

  static const String memosPath = '/api/memos';
  static const String settingsPath = '/api/settings';

  static String _defaultUrl() {
    if (kIsWeb) return 'http://localhost:5000';
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:5000';
    }
    return 'http://localhost:5000';
  }
}
