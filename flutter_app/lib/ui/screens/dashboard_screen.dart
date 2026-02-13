import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/memo_provider.dart';
import '../../providers/pet_provider.dart';
import '../widgets/memo_card.dart';
import '../widgets/pet_avatar.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petAsync = ref.watch(activePetProvider);
    final memosAsync = ref.watch(memoListProvider);

    return petAsync.when(
      loading: () => _buildLoading(context),
      error: (e, _) => _buildError(context, e),
      data: (pet) {
        final petName = pet?.petName ?? '친구';
        final petType = pet?.petType ?? 'shiba';

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                PetAvatar(petType: petType, size: PetSize.md),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$petName의 코너',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    Text(
                      '돌아왔구나, 주인님',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: Colors.grey.shade600),
                onPressed: () => context.push('/settings'),
              ),
            ],
          ),
          body: memosAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('오류: $e')),
            data: (memos) {
              if (memos.isEmpty) {
                return _buildEmptyState(context, petName, petType);
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: memos.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final memo = memos[index];
                  return MemoCard(
                    id: memo.id,
                    content: memo.content,
                    petResponse: memo.petResponse,
                    createdAt: memo.createdAt,
                    petType: petType,
                    petName: petName,
                    onDelete: () {
                      ref.read(memoActionsProvider).deleteMemo(memo.id);
                    },
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push('/create-memo'),
            icon: const Icon(Icons.add),
            label: const Text('메모 쓰기'),
          ).animate().scale(delay: 300.ms, duration: 400.ms),
        );
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
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
            const SizedBox(height: 16),
            Text(
              '펫을 깨우는 중...',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey.shade500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return Scaffold(
      body: Center(child: Text('오류가 발생했습니다: $error')),
    );
  }

  Widget _buildEmptyState(
      BuildContext context, String petName, String petType) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PetAvatar(
              petType: petType,
              size: PetSize.xl,
              mood: PetMood.sleeping,
            ),
            const SizedBox(height: 24),
            Text(
              '아직 기록이 없어요',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '$petName이(가) 주인님 이야기를\n기다리고 있어요!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
