import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/memos_table.dart';
import 'tables/pet_table.dart';
import 'tables/user_settings_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [MemoEntries, PetEntries, UserSettingsEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'pet_memo',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }

  // --- Pet operations ---

  Future<PetEntry?> getActivePet() {
    return (select(petEntries)..where((t) => t.isActive.equals(true)))
        .getSingleOrNull();
  }

  Stream<PetEntry?> watchActivePet() {
    return (select(petEntries)..where((t) => t.isActive.equals(true)))
        .watchSingleOrNull();
  }

  Future<int> insertPet(PetEntriesCompanion pet) {
    return into(petEntries).insert(pet);
  }

  Future<bool> updatePet(PetEntry pet) {
    return update(petEntries).replace(pet);
  }

  // --- Memo operations ---

  Stream<List<MemoEntry>> watchAllMemos() {
    return (select(memoEntries)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<List<MemoEntry>> getAllMemos() {
    return (select(memoEntries)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> insertMemo(MemoEntriesCompanion memo) {
    return into(memoEntries).insert(memo);
  }

  Future<void> updateMemoResponse(int id, String? petResponse, int? serverId) {
    return (update(memoEntries)..where((t) => t.id.equals(id))).write(
      MemoEntriesCompanion(
        petResponse: Value(petResponse),
        serverId: Value(serverId),
        isSynced: const Value(true),
      ),
    );
  }

  Future<int> deleteMemoById(int id) {
    return (delete(memoEntries)..where((t) => t.id.equals(id))).go();
  }

  // --- Settings operations ---

  Future<UserSettingsEntry?> getSettings() {
    return (select(userSettingsEntries)..limit(1)).getSingleOrNull();
  }

  Future<UserSettingsEntry> getOrCreateSettings() async {
    final existing = await getSettings();
    if (existing != null) return existing;
    final id = await into(userSettingsEntries)
        .insert(UserSettingsEntriesCompanion.insert());
    return (select(userSettingsEntries)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<void> markGachaComplete() async {
    final settings = await getOrCreateSettings();
    await (update(userSettingsEntries)
          ..where((t) => t.id.equals(settings.id)))
        .write(const UserSettingsEntriesCompanion(
            gachaComplete: Value(true)));
  }

  Future<void> markNamingComplete() async {
    final settings = await getOrCreateSettings();
    await (update(userSettingsEntries)
          ..where((t) => t.id.equals(settings.id)))
        .write(const UserSettingsEntriesCompanion(
      namingComplete: Value(true),
      onboardingComplete: Value(true),
    ));
  }

  Future<void> updateServerUrl(String url) async {
    final settings = await getOrCreateSettings();
    await (update(userSettingsEntries)
          ..where((t) => t.id.equals(settings.id)))
        .write(UserSettingsEntriesCompanion(serverUrl: Value(url)));
  }

  Future<void> resetAllData() async {
    await delete(memoEntries).go();
    await delete(petEntries).go();
    await delete(userSettingsEntries).go();
  }
}
