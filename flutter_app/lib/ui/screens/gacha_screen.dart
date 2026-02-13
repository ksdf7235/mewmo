import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/pet_constants.dart';
import '../../providers/pet_provider.dart';
import '../widgets/gacha_egg.dart';
import '../widgets/pet_avatar.dart';

class GachaScreen extends ConsumerStatefulWidget {
  const GachaScreen({super.key});

  @override
  ConsumerState<GachaScreen> createState() => _GachaScreenState();
}

class _GachaScreenState extends ConsumerState<GachaScreen> {
  // 0: egg, 1: hatching, 2: revealed
  int _phase = 0;
  PetType? _result;

  Future<void> _hatch() async {
    if (_phase != 0) return;
    setState(() => _phase = 1);

    // 가챠 실행
    final result = await ref.read(petActionsProvider).performGacha();

    // 부화 연출
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    setState(() {
      _phase = 2;
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF3E0), // warm orange-50
              Colors.white,
              Color(0xFFF3E5F5), // light purple-50
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_phase == 0 || _phase == 1) ...[
                    // 안내 텍스트
                    Text(
                      '알을 터치해보세요!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: -0.3, end: 0),
                    const SizedBox(height: 48),
                    // 알
                    GachaEgg(onHatchComplete: _hatch),
                    const SizedBox(height: 32),
                    if (_phase == 1)
                      const CircularProgressIndicator()
                          .animate()
                          .fadeIn(duration: 300.ms),
                  ],
                  if (_phase == 2 && _result != null) ...[
                    // 펫 등장
                    PetAvatar(
                      petType: _result!.name,
                      size: PetSize.xl,
                      mood: PetMood.happy,
                    )
                        .animate()
                        .scale(
                          begin: const Offset(0.3, 0.3),
                          end: const Offset(1, 1),
                          duration: 600.ms,
                          curve: Curves.elasticOut,
                        )
                        .fadeIn(duration: 400.ms),

                    const SizedBox(height: 24),

                    // "당신의 단짝이 태어났어요!"
                    Text(
                      '당신의 단짝이 태어났어요!',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 300.ms, duration: 500.ms),

                    const SizedBox(height: 8),

                    // 펫 타입 표시
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _getRarityColor(_result!.rarity)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _getRarityColor(_result!.rarity)
                              .withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        '${_result!.emoji} ${_result!.displayName} (${_result!.rarity})',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _getRarityColor(_result!.rarity),
                        ),
                      ),
                    ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

                    const SizedBox(height: 48),

                    // 다음 버튼
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => context.go('/naming'),
                        child: const Text('다음', style: TextStyle(fontSize: 18)),
                      ),
                    ).animate().fadeIn(delay: 800.ms, duration: 400.ms),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getRarityColor(String rarity) {
    return switch (rarity) {
      'legendary' => Colors.deepPurple,
      'rare' => Colors.blue,
      _ => Colors.orange,
    };
  }
}
