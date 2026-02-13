import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GachaEgg extends StatelessWidget {
  final VoidCallback? onHatchComplete;

  const GachaEgg({super.key, this.onHatchComplete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onHatchComplete,
      child: Container(
        width: 160,
        height: 200,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
              Color(0xFFFFCC80),
            ],
          ),
          borderRadius: BorderRadius.circular(80)
              .copyWith(bottomLeft: const Radius.circular(60), bottomRight: const Radius.circular(60)),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 알 무늬
            Positioned(
              top: 50,
              child: Container(
                width: 100,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Positioned(
              top: 80,
              child: Container(
                width: 120,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // 물음표
            const Text(
              '?',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
            // 반짝임
            Positioned(
              top: 30,
              right: 30,
              child: Icon(Icons.auto_awesome,
                  size: 16, color: Colors.orange.shade300),
            ),
          ],
        ),
      )
          .animate(onPlay: (c) => c.repeat())
          .rotate(begin: -0.03, end: 0.03, duration: 300.ms)
          .then()
          .rotate(begin: 0.03, end: -0.03, duration: 300.ms)
          .then()
          .rotate(begin: -0.04, end: 0.04, duration: 250.ms)
          .then()
          .rotate(begin: 0.04, end: -0.04, duration: 250.ms)
          .then(delay: 500.ms),
    );
  }
}
