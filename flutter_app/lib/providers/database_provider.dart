import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/app_database.dart';
import '../data/services/api_client.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
