import 'dart:math';

enum PetType {
  shiba(
    displayName: '시바견',
    sound: '멍',
    probability: 0.40,
    rarity: 'common',
    emoji: '🐕',
    serverType: 'dog',
  ),
  cheeseCat(
    displayName: '치즈냥이',
    sound: '냥',
    probability: 0.40,
    rarity: 'common',
    emoji: '🐱',
    serverType: 'cat',
  ),
  rabbit(
    displayName: '토끼',
    sound: '깡충',
    probability: 0.08,
    rarity: 'rare',
    emoji: '🐰',
    serverType: 'rabbit',
  ),
  hamster(
    displayName: '햄스터',
    sound: '찍찍',
    probability: 0.07,
    rarity: 'rare',
    emoji: '🐹',
    serverType: 'hamster',
  ),
  babyDragon(
    displayName: '아기 용',
    sound: '크르릉',
    probability: 0.05,
    rarity: 'legendary',
    emoji: '🐉',
    serverType: 'dragon',
  );

  final String displayName;
  final String sound;
  final double probability;
  final String rarity;
  final String emoji;
  final String serverType;

  const PetType({
    required this.displayName,
    required this.sound,
    required this.probability,
    required this.rarity,
    required this.emoji,
    required this.serverType,
  });

  static PetType fromServerType(String type) {
    return PetType.values.firstWhere(
      (e) => e.serverType == type,
      orElse: () => PetType.shiba,
    );
  }

  static PetType fromName(String name) {
    return PetType.values.firstWhere(
      (e) => e.name == name,
      orElse: () => PetType.shiba,
    );
  }
}

class GachaEngine {
  static final _random = Random();

  static PetType roll() {
    final roll = _random.nextDouble();
    double cumulative = 0.0;

    for (final type in PetType.values) {
      cumulative += type.probability;
      if (roll < cumulative) return type;
    }

    return PetType.shiba;
  }
}
