import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/app_database.dart';
import '../data/services/api_client.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  // ignore: avoid_print
  print('[LOAD] databaseProvider AppDatabase 생성 시작 ${DateTime.now()}');
  final db = AppDatabase();
  // ignore: avoid_print
  print('[LOAD] databaseProvider AppDatabase 생성 완료 ${DateTime.now()}');
  ref.onDispose(() => db.close());
  return db;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
