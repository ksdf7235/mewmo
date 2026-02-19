import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database_provider.dart';

enum OnboardingState {
  loading,
  needsGacha,
  needsNaming,
  complete,
}

final onboardingStateProvider = FutureProvider<OnboardingState>((ref) async {
  // ignore: avoid_print
  print('[LOAD] onboardingStateProvider 시작 ${DateTime.now()}');
  final db = ref.watch(databaseProvider);
  // ignore: avoid_print
  print('[LOAD] onboardingStateProvider db.getSettings() 호출 ${DateTime.now()}');
  final settings = await db.getSettings();
  // ignore: avoid_print
  print('[LOAD] onboardingStateProvider getSettings 완료 ${DateTime.now()}');

  if (settings == null || !settings.gachaComplete) {
    return OnboardingState.needsGacha;
  }

  if (!settings.namingComplete) {
    return OnboardingState.needsNaming;
  }

  return OnboardingState.complete;
});
