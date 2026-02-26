import 'package:flutter/material.dart';
import 'package:my_archive/core/animations/bounce_animation.dart';
import 'package:my_archive/core/animations/fade_animation.dart';
import 'package:my_archive/core/animations/pulse_animation.dart';
import 'package:my_archive/core/animations/rotation_animation.dart';
import 'package:my_archive/core/animations/scale_animation.dart';
import 'package:my_archive/core/animations/shake_animation.dart';
import 'package:my_archive/core/animations/slide_animation.dart';
import 'package:my_archive/core/animations/stagger_animation.dart';

class DemoAnimations extends StatelessWidget {
  const DemoAnimations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionTitle('1. Fade Animation'),
          const FadeAnimationDemo(),
          const SizedBox(height: 20),
          _SectionTitle('2. Slide Animation'),
          const SlideAnimationDemo(),
          const SizedBox(height: 20),
          _SectionTitle('3. Scale Animation'),
          const ScaleAnimationDemo(),
          const SizedBox(height: 20),
          _SectionTitle('4. Rotation Animation'),
          const RotationAnimationDemo(),
          const SizedBox(height: 20),
          _SectionTitle('5. Bounce Animation'),
          const BounceAnimationDemo(),
          const SizedBox(height: 20),
          _SectionTitle('6. Shake Animation'),
          const ShakeAnimationDemo(),
          const SizedBox(height: 20),
          _SectionTitle('7. Pulse Animation'),
          const PulseAnimationDemo(),
          const SizedBox(height: 20),
          _SectionTitle('8. Stagger Animation'),
          const StaggerAnimationDemo(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF0F3460),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          backgroundColor: Color(0xFFE94560),
        ),
      ),
    );
  }
}
