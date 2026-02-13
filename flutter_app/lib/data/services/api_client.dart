import 'package:dio/dio.dart';
import '../../config/api_config.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ));

    if (ApiConfig.apiKey != null) {
      _dio.options.headers['x-api-key'] = ApiConfig.apiKey;
    }
  }

  void updateBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  /// GET /api/memos
  Future<List<Map<String, dynamic>>> getMemos() async {
    final response = await _dio.get(ApiConfig.memosPath);
    return List<Map<String, dynamic>>.from(response.data);
  }

  /// POST /api/memos - 서버에서 OpenAI로 펫 반응 생성
  Future<Map<String, dynamic>> createMemo(String content,
      {String? imageUrl, String? customPrompt}) async {
    final data = <String, dynamic>{
      'content': content,
    };
    if (imageUrl != null) data['imageUrl'] = imageUrl;
    if (customPrompt != null) data['customPrompt'] = customPrompt;
    final response = await _dio.post(ApiConfig.memosPath, data: data);
    return Map<String, dynamic>.from(response.data);
  }

  /// DELETE /api/memos/:id
  Future<void> deleteMemo(int id) async {
    await _dio.delete('${ApiConfig.memosPath}/$id');
  }

  /// PUT /api/settings - 서버에 펫 설정 동기화
  Future<void> updateSettings({
    required String petName,
    required String petType,
  }) async {
    await _dio.put(ApiConfig.settingsPath, data: {
      'petName': petName,
      'petType': petType,
    });
  }
}
