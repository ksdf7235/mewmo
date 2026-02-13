import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/date_formatter.dart';
import 'pet_avatar.dart';

class MemoCard extends StatelessWidget {
  final int id;
  final String content;
  final String? petResponse;
  final DateTime createdAt;
  final String petType;
  final String petName;
  final VoidCallback? onDelete;

  const MemoCard({
    super.key,
    required this.id,
    required this.content,
    this.petResponse,
    required this.createdAt,
    required this.petType,
    required this.petName,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 그라데이션 바
          Container(
            height: 3,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                  Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 헤더: 시간 + 삭제 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        formatRelativeDate(createdAt),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    if (onDelete != null)
                      IconButton(
                        icon: Icon(Icons.delete_outline,
                            size: 20, color: Colors.grey.shade400),
                        onPressed: () => _showDeleteConfirm(context),
                      ),
                  ],
                ),

                const SizedBox(height: 12),

                // 사용자 메모 내용
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Color(0xFF333333),
                  ),
                ),

                const SizedBox(height: 20),

                // 펫 반응
                if (petResponse != null)
                  _buildPetResponse(context)
                else
                  _buildThinking(context),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildPetResponse(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        PetAvatar(petType: petType, size: PetSize.sm),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$petName:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  petResponse!,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF444444),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThinking(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          PetAvatar(petType: petType, size: PetSize.sm, mood: PetMood.thinking),
          const SizedBox(width: 8),
          Text(
            '$petName이(가) 읽는 중...',
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('메모 삭제'),
        content: const Text('이 메모를 삭제하시겠습니까? 되돌릴 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onDelete?.call();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
