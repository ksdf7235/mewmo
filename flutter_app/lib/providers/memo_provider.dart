import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/pet_constants.dart';
import '../data/database/app_database.dart';
import '../utils/korean_prompts.dart';
import '../utils/offline_responses.dart';
import 'database_provider.dart';

final memoListProvider = StreamProvider<List<MemoEntry>>((ref) {
  // ignore: avoid_print
  print('[LOAD] memoListProvider watchAllMemos 구독 시작 ${DateTime.now()}');
  final db = ref.watch(databaseProvider);
  return db.watchAllMemos();
});

final memoActionsProvider = Provider<MemoActions>((ref) {
  return MemoActions(ref);
});

class MemoActions {
  final Ref _ref;
  MemoActions(this._ref);

  AppDatabase get _db => _ref.read(databaseProvider);

  Future<void> createMemo(String content) async {
    // 1. 로컬에 먼저 저장
    final localId = await _db.insertMemo(
      MemoEntriesCompanion.insert(content: content),
    );

    // 2. 서버에서 AI 반응 가져오기
    try {
      final pet = await _db.getActivePet();
      final apiClient = _ref.read(apiClientProvider);

      String? customPrompt;
      if (pet != null) {
        final petType = PetType.fromName(pet.petType);
        customPrompt = buildKoreanPrompt(
          petType: petType.displayName,
          petName: pet.petName ?? '친구',
          petSound: pet.petSound,
          userMemoText: content,
        );
      }

      final serverMemo = await apiClient.createMemo(
        content,
        customPrompt: customPrompt,
      );

      // 3. 로컬 메모에 서버 반응 업데이트
      await _db.updateMemoResponse(
        localId,
        serverMemo['petResponse'] as String?,
        serverMemo['id'] as int?,
      );
    } catch (_) {
      // 오프라인: 로컬 템플릿으로 대체 응답 생성
      final pet = await _db.getActivePet();
      if (pet != null) {
        final offlineResponse = generateOfflineResponse(
          petName: pet.petName ?? '친구',
          petSound: pet.petSound,
          content: content,
        );
        await _db.updateMemoResponse(localId, offlineResponse, null);
      }
    }
  }

  Future<void> deleteMemo(int id) async {
    // 로컬에서 먼저 가져와서 serverId 확인
    final memos = await _db.getAllMemos();
    final memo = memos.where((m) => m.id == id).firstOrNull;

    await _db.deleteMemoById(id);

    // 서버에서도 삭제 시도
    if (memo?.serverId != null) {
      try {
        final apiClient = _ref.read(apiClientProvider);
        await apiClient.deleteMemo(memo!.serverId!);
      } catch (_) {
        // 무시
      }
    }
  }
}
