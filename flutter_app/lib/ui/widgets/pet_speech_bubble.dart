import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PetSpeechBubble extends StatelessWidget {
  final String text;
  final String? petName;

  const PetSpeechBubble({
    super.key,
    required this.text,
    this.petName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (petName != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                petName!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                ),
              ),
            ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Color(0xFF444444),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0);
  }
}
