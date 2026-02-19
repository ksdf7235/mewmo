import 'package:shared_preferences/shared_preferences.dart';

/// shared_preferences 기반 pet 캐시 (localStorage on web).
/// 앱 새로고침 시 DB 로딩 전 즉시 표시용.
class PetCache {
  static const _keyPetType = 'pet_type';
  static const _keyPetSound = 'pet_sound';
  static const _keyPetName = 'pet_name';
  static const _keyGachaComplete = 'gacha_complete';
  static const _keyNamingComplete = 'naming_complete';

  static Map<String, dynamic>? _memory;

  static Future<Map<String, dynamic>> _ensureLoaded() async {
    if (_memory != null) return _memory!;
    final prefs = await SharedPreferences.getInstance();
    _memory = {
      _keyPetType: prefs.getString(_keyPetType),
      _keyPetSound: prefs.getString(_keyPetSound),
      _keyPetName: prefs.getString(_keyPetName),
      _keyGachaComplete: prefs.getBool(_keyGachaComplete) ?? false,
      _keyNamingComplete: prefs.getBool(_keyNamingComplete) ?? false,
    };
    return _memory!;
  }

  static void _updateMem(String key, dynamic value) {
    _memory?[key] = value;
  }

  static Future<String?> getPetType() async {
    final m = await _ensureLoaded();
    return m[_keyPetType] as String?;
  }

  static Future<String?> getPetSound() async {
    final m = await _ensureLoaded();
    return m[_keyPetSound] as String?;
  }

  static Future<String?> getPetName() async {
    final m = await _ensureLoaded();
    return m[_keyPetName] as String?;
  }

  static Future<bool> getGachaComplete() async {
    final m = await _ensureLoaded();
    return m[_keyGachaComplete] as bool;
  }

  static Future<bool> getNamingComplete() async {
    final m = await _ensureLoaded();
    return m[_keyNamingComplete] as bool;
  }

  static Future<void> saveGachaResult(String petType, String petSound) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPetType, petType);
    await prefs.setString(_keyPetSound, petSound);
    await prefs.setBool(_keyGachaComplete, true);
    _updateMem(_keyPetType, petType);
    _updateMem(_keyPetSound, petSound);
    _updateMem(_keyGachaComplete, true);
  }

  static Future<void> saveNamingResult(String petName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPetName, petName);
    await prefs.setBool(_keyNamingComplete, true);
    _updateMem(_keyPetName, petName);
    _updateMem(_keyNamingComplete, true);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyPetType);
    await prefs.remove(_keyPetSound);
    await prefs.remove(_keyPetName);
    await prefs.remove(_keyGachaComplete);
    await prefs.remove(_keyNamingComplete);
    _memory = null;
  }
}
