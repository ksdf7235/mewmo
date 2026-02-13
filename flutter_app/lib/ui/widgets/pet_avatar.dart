import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/pet_constants.dart';

enum PetMood { happy, thinking, sleeping }

enum PetSize { sm, md, lg, xl }

class PetAvatar extends StatelessWidget {
  final String petType;
  final PetSize size;
  final PetMood mood;

  const PetAvatar({
    super.key,
    required this.petType,
    this.size = PetSize.md,
    this.mood = PetMood.happy,
  });

  double get _size => switch (size) {
        PetSize.sm => 40,
        PetSize.md => 56,
        PetSize.lg => 80,
        PetSize.xl => 128,
      };

  double get _iconSize => switch (size) {
        PetSize.sm => 20,
        PetSize.md => 28,
        PetSize.lg => 40,
        PetSize.xl => 64,
      };

  Color get _iconColor {
    final type = petType.toLowerCase();
    if (type == 'cat' || type == 'cheesecat' || type == 'cheese_cat') {
      return Colors.orange;
    }
    if (type == 'rabbit') return Colors.pink;
    if (type == 'hamster') return Colors.amber;
    if (type == 'dragon' || type == 'babydragon' || type == 'baby_dragon') {
      return Colors.deepPurple;
    }
    return Colors.brown; // dog
  }

  Color get _bgColor {
    final type = petType.toLowerCase();
    if (type == 'cat' || type == 'cheesecat' || type == 'cheese_cat') {
      return Colors.orange.shade50;
    }
    if (type == 'rabbit') return Colors.pink.shade50;
    if (type == 'hamster') return Colors.amber.shade50;
    if (type == 'dragon' || type == 'babydragon' || type == 'baby_dragon') {
      return Colors.deepPurple.shade50;
    }
    return Colors.amber.shade50; // dog
  }

  String get _emoji {
    try {
      return PetType.fromName(petType).emoji;
    } catch (_) {
      return PetType.fromServerType(petType).emoji;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar = Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: _bgColor,
        shape: BoxShape.circle,
        border: Border.all(color: _iconColor.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: _iconColor.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          _emoji,
          style: TextStyle(fontSize: _iconSize * 0.8),
        ),
      ),
    );

    return switch (mood) {
      PetMood.happy => avatar
          .animate(onPlay: (c) => c.repeat())
          .moveY(begin: 0, end: -5, duration: 1.seconds)
          .then()
          .moveY(begin: -5, end: 0, duration: 1.seconds),
      PetMood.thinking => avatar
          .animate(onPlay: (c) => c.repeat())
          .rotate(begin: -0.02, end: 0.02, duration: 1500.ms)
          .then()
          .rotate(begin: 0.02, end: -0.02, duration: 1500.ms),
      PetMood.sleeping => avatar
          .animate(onPlay: (c) => c.repeat())
          .scale(begin: const Offset(1, 1), end: const Offset(0.95, 0.95), duration: 2.seconds)
          .then()
          .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1), duration: 2.seconds)
          .fadeIn(begin: 0.7, duration: 2.seconds),
    };
  }
}
