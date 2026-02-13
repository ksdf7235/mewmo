import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/pet_constants.dart';
import '../../providers/pet_provider.dart';
import '../widgets/pet_avatar.dart';
import '../widgets/pet_speech_bubble.dart';

class NamingScreen extends ConsumerStatefulWidget {
  const NamingScreen({super.key});

  @override
  ConsumerState<NamingScreen> createState() => _NamingScreenState();
}

class _NamingScreenState extends ConsumerState<NamingScreen> {
  final _nameController = TextEditingController();
  // 1: 이름 짓기 요청, 2: 입력 중, 3: 완료
  int _step = 1;
  String _confirmedName = '';

  @override
  void initState() {
    super.initState();
    // step 1에서 잠시 후 step 2로
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _step = 2);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String get _petSound {
    final petAsync = ref.read(activePetProvider);
    return petAsync.whenOrNull(data: (pet) => pet?.petSound) ?? '멍';
  }

  String get _petType {
    final petAsync = ref.read(activePetProvider);
    return petAsync.whenOrNull(data: (pet) => pet?.petType) ?? 'shiba';
  }

  String get _petDisplayName {
    try {
      return PetType.fromName(_petType).displayName;
    } catch (_) {
      return '시바견';
    }
  }

  String get _dialogueText {
    if (_step == 1 || _step == 2) {
      return '내 이름을 지어줄래? $_petSound!';
    }
    return '$_confirmedName? 마음에 들어! 잘 부탁해 주인님! $_petSound!';
  }

  Future<void> _confirmName() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    await ref.read(petActionsProvider).namePet(name);

    setState(() {
      _confirmedName = name;
      _step = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF8E1),
              Color(0xFFFAF8F5),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 펫 아바타
                  PetAvatar(
                    petType: _petType,
                    size: PetSize.xl,
                    mood: PetMood.happy,
                  ),

                  const SizedBox(height: 12),

                  // 펫 타입 표시
                  Text(
                    _petDisplayName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                  ),

                  const SizedBox(height: 24),

                  // 말풍선
                  PetSpeechBubble(text: _dialogueText),

                  const SizedBox(height: 32),

                  // Step 2: 이름 입력
                  if (_step == 2) ...[
                    TextField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        hintText: '이름을 입력해주세요...',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      maxLength: 10,
                      onSubmitted: (_) => _confirmName(),
                    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _confirmName,
                        child: const Text('확인', style: TextStyle(fontSize: 18)),
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                  ],

                  // Step 3: 시작 버튼
                  if (_step == 3) ...[
                    const SizedBox(height: 16),
                    // 반짝임 효과
                    const Icon(
                      Icons.auto_awesome,
                      size: 32,
                      color: Colors.amber,
                    )
                        .animate(onPlay: (c) => c.repeat())
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1.2, 1.2),
                          duration: 1.seconds,
                        )
                        .then()
                        .scale(
                          begin: const Offset(1.2, 1.2),
                          end: const Offset(0.8, 0.8),
                          duration: 1.seconds,
                        ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => context.go('/dashboard'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2D2D2D),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('시작하기', style: TextStyle(fontSize: 18)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
