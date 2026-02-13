import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/pet_constants.dart';
import '../data/database/app_database.dart';
import 'database_provider.dart';

final activePetProvider = StreamProvider<PetEntry?>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchActivePet();
});

final petActionsProvider = Provider<PetActions>((ref) {
  return PetActions(ref);
});

class PetActions {
  final Ref _ref;
  PetActions(this._ref);

  AppDatabase get _db => _ref.read(databaseProvider);

  Future<PetType> performGacha() async {
    final result = GachaEngine.roll();

    await _db.insertPet(PetEntriesCompanion.insert(
      petType: result.name,
      petSound: result.sound,
    ));

    await _db.markGachaComplete();
    return result;
  }

  Future<void> namePet(String name) async {
    final pet = await _db.getActivePet();
    if (pet == null) return;

    await _db.updatePet(pet.copyWith(petName: Value(name)));
    await _db.markNamingComplete();

    // 서버에도 동기화 시도
    try {
      final api = _ref.read(apiClientProvider);
      final petType = PetType.fromName(pet.petType);
      await api.updateSettings(petName: name, petType: petType.serverType);
    } catch (_) {
      // 오프라인이면 무시
    }
  }
}
