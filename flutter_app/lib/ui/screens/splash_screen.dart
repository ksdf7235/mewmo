import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/onboarding_provider.dart';
import '../widgets/pet_avatar.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    debugPrint('[LOAD] SplashScreen._navigate 시작 ${DateTime.now()}');
    // 약간의 딜레이로 스플래시 표시
    await Future.delayed(const Duration(milliseconds: 800));
    debugPrint('[LOAD] SplashScreen 800ms 딜레이 완료 ${DateTime.now()}');
    if (!mounted) return;

    debugPrint('[LOAD] onboardingStateProvider.future 대기 시작 ${DateTime.now()}');
    final state = await ref.read(onboardingStateProvider.future);
    debugPrint('[LOAD] onboardingStateProvider 완료 → $state ${DateTime.now()}');

    if (!mounted) return;
    switch (state) {
      case OnboardingState.needsGacha:
        debugPrint('[LOAD] SplashScreen → /gacha 이동 ${DateTime.now()}');
        context.go('/gacha');
      case OnboardingState.needsNaming:
        debugPrint('[LOAD] SplashScreen → /naming 이동 ${DateTime.now()}');
        context.go('/naming');
      case OnboardingState.complete:
        debugPrint('[LOAD] SplashScreen → /dashboard 이동 ${DateTime.now()}');
        context.go('/dashboard');
      case OnboardingState.loading:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PetAvatar(
              petType: 'shiba',
              size: PetSize.lg,
              mood: PetMood.thinking,
            ),
            const SizedBox(height: 20),
            Text(
              '잠깐만요...',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey.shade500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
