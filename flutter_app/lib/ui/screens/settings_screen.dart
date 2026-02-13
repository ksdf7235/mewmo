import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/api_config.dart';
import '../../config/pet_constants.dart';
import '../../providers/database_provider.dart';
import '../../providers/pet_provider.dart';
import '../widgets/pet_avatar.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _nameController = TextEditingController();
  final _serverUrlController = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _serverUrlController.text = ApiConfig.baseUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _serverUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveName() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _isSaving = true);
    await ref.read(petActionsProvider).namePet(name);
    setState(() => _isSaving = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이름이 변경되었어요!'),
            backgroundColor: Color(0xFFE8927C)),
      );
    }
  }

  Future<void> _saveServerUrl() async {
    final url = _serverUrlController.text.trim();
    if (url.isEmpty) return;

    ApiConfig.baseUrl = url;
    ref.read(apiClientProvider).updateBaseUrl(url);
    await ref.read(databaseProvider).updateServerUrl(url);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('서버 주소가 저장되었어요!')),
      );
    }
  }

  Future<void> _resetData() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('데이터 초기화'),
        content: const Text('모든 데이터가 삭제되고 처음부터 시작합니다. 계속하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('초기화'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await ref.read(databaseProvider).resetAllData();
      if (mounted) context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final petAsync = ref.watch(activePetProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('설정'),
      ),
      body: petAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (pet) {
          final petName = pet?.petName ?? '친구';
          final petType = pet?.petType ?? 'shiba';
          _nameController.text = _nameController.text.isEmpty
              ? petName
              : _nameController.text;

          PetType petTypeEnum;
          try {
            petTypeEnum = PetType.fromName(petType);
          } catch (_) {
            petTypeEnum = PetType.shiba;
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 펫 프로필 카드
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      PetAvatar(petType: petType, size: PetSize.xl),
                      const SizedBox(height: 12),
                      Text(
                        petName,
                        style:
                            Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          petTypeEnum.displayName,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 펫 이름 변경
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '펫 이름',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: '펫 이름을 입력해주세요',
                        ),
                        maxLength: 10,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isSaving ? null : _saveName,
                          child: Text(_isSaving ? '저장 중...' : '저장'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 서버 설정
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '서버 주소',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'AI 반응을 생성하는 서버의 주소입니다',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _serverUrlController,
                        decoration: const InputDecoration(
                          hintText: 'http://...',
                        ),
                        keyboardType: TextInputType.url,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveServerUrl,
                          child: const Text('저장'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 데이터 초기화
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '데이터 관리',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _resetData,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                          ),
                          child: const Text('모든 데이터 초기화'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
