import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/pet_constants.dart';
import '../data/database/app_database.dart';
import '../utils/pet_cache.dart';
import 'database_provider.dart';

final petCacheProvider = FutureProvider<({String? type, String? sound, String? name})>((ref) async {
  final type = await PetCache.getPetType();
  final sound = await PetCache.getPetSound();
  final name = await PetCache.getPetName();
  return (type: type, sound: sound, name: name);
});

final activePetProvider = StreamProvider<PetEntry?>((ref) {
  // ignore: avoid_print
  print('[LOAD] activePetProvider watchActivePet 구독 시작 ${DateTime.now()}');
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
    await PetCache.saveGachaResult(result.name, result.sound);
    return result;
  }

  Future<void> namePet(String name) async {
    final pet = await _db.getActivePet();
    if (pet == null) return;

    await _db.updatePet(pet.copyWith(petName: Value(name)));
    await _db.markNamingComplete();
    await PetCache.saveNamingResult(name);

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
