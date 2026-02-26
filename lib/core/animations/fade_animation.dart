import 'package:flutter/material.dart';

/// FadeAnimation - elementni asta-sekin ko'rsatadi/yashiradi
/// [onComplete] - animatsiya tugagandan keyin chaqiriladi
class FadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double begin;
  final double end;
  final VoidCallback? onComplete;

  const FadeAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.begin = 0.0,
    this.end = 1.0,
    this.onComplete,
  });

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: widget.begin, end: widget.end).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}

// ─── Demo ────────────────────────────────────────────────────────────────────

class FadeAnimationDemo extends StatefulWidget {
  const FadeAnimationDemo({super.key});

  @override
  State<FadeAnimationDemo> createState() => _FadeAnimationDemoState();
}

class _FadeAnimationDemoState extends State<FadeAnimationDemo> {
  bool _show = true;
  Key _key = UniqueKey();
  String _status = '⏳ Animatsiya boshlanmoqda...';

  void _replay() {
    setState(() {
      _show = false;
      _status = '⏳ Animatsiya boshlanmoqda...';
    });
    Future.microtask(() => setState(() {
          _show = true;
          _key = UniqueKey();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF16213E), borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        if (_show)
          FadeAnimation(
            key: _key,
            duration: const Duration(milliseconds: 1200),
            onComplete: () => setState(() => _status = '✅ Fade tugadi! Endi navbatdagi qadam...'),
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF0F3460), Color(0xFFE94560)]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                  child: Text('✨ Men asta-sekin paydo bo\'ldim!', style: TextStyle(color: Colors.white, fontSize: 16))),
            ),
          ),
        const SizedBox(height: 8),
        Text(_status, style: const TextStyle(color: Color(0xFFFFB703), fontSize: 13)),
        const SizedBox(height: 8),
        ElevatedButton(
            onPressed: _replay,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE94560)),
            child: const Text('▶ Qayta ijro', style: TextStyle(color: Colors.white))),
      ]),
    );
  }
}
