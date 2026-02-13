import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/memo_provider.dart';

class CreateMemoScreen extends ConsumerStatefulWidget {
  const CreateMemoScreen({super.key});

  @override
  ConsumerState<CreateMemoScreen> createState() => _CreateMemoScreenState();
}

class _CreateMemoScreenState extends ConsumerState<CreateMemoScreen> {
  final _contentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final content = _contentController.text.trim();
    if (content.isEmpty || _isSubmitting) return;

    setState(() => _isSubmitting = true);

    try {
      await ref.read(memoActionsProvider).createMemo(content);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('메모가 저장되었어요! 펫이 반응을 생각하고 있어요...'),
            backgroundColor: Color(0xFFE8927C),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('오류가 발생했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, size: 20, color: Color(0xFFE8927C)),
            SizedBox(width: 8),
            Text('새로운 기록'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 메모 입력
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: const TextStyle(fontSize: 18, height: 1.6),
                decoration: InputDecoration(
                  hintText: '오늘 있었던 일을 적어봐...',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(20),
                ),
                enabled: !_isSubmitting,
              ),
            ),

            const SizedBox(height: 16),

            // 제출 버튼
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('보내는 중...', style: TextStyle(fontSize: 16)),
                        ],
                      )
                    : const Text('펫에게 보내기', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
