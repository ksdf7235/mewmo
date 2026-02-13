import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database_provider.dart';

enum OnboardingState {
  loading,
  needsGacha,
  needsNaming,
  complete,
}

final onboardingStateProvider = FutureProvider<OnboardingState>((ref) async {
  final db = ref.watch(databaseProvider);
  final settings = await db.getSettings();

  if (settings == null || !settings.gachaComplete) {
    return OnboardingState.needsGacha;
  }

  if (!settings.namingComplete) {
    return OnboardingState.needsNaming;
  }

  return OnboardingState.complete;
});
