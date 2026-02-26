import 'package:flutter/material.dart';

/// BounceAnimation - elementni sakratib ko'rsatadi
/// [onComplete] - animatsiya tugagandan keyin chaqiriladi (repeat=false bo'lsa)
class BounceAnimation extends StatefulWidget {
  final Widget child;
  final double bounceHeight;
  final Duration duration;
  final bool repeat;
  final VoidCallback? onComplete;

  const BounceAnimation({
    super.key,
    required this.child,
    this.bounceHeight = 20.0,
    this.duration = const Duration(milliseconds: 600),
    this.repeat = false,
    this.onComplete,
  });

  @override
  State<BounceAnimation> createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: widget.bounceHeight).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );

    if (!widget.repeat) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete?.call();
        }
      });
    }

    if (widget.repeat) {
      _controller.repeat(reverse: true);
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

// ─── Demo ────────────────────────────────────────────────────────────────────

class BounceAnimationDemo extends StatefulWidget {
  const BounceAnimationDemo({super.key});

  @override
  State<BounceAnimationDemo> createState() => _BounceAnimationDemoState();
}

class _BounceAnimationDemoState extends State<BounceAnimationDemo> {
  Key _starKey = UniqueKey();
  String _status = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Uzluksiz bounce - onComplete yo'q
              BounceAnimation(
                repeat: true,
                duration: const Duration(milliseconds: 800),
                bounceHeight: 30,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE94560),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(child: Text('🏀', style: TextStyle(fontSize: 24))),
                ),
              ),

              // Bir marta - onComplete bor
              BounceAnimation(
                key: _starKey,
                duration: const Duration(seconds: 1),
                bounceHeight: 40,
                onComplete: () => setState(() => _status = '✅ Bounce tugadi! Confetti chiqarish vaqti 🎉'),
                child: const Text('⭐', style: TextStyle(fontSize: 40)),
              ),

              // Uzluksiz bounce
              BounceAnimation(
                repeat: true,
                duration: const Duration(milliseconds: 500),
                bounceHeight: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F3460),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('SALOM!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_status.isNotEmpty) Text(_status, style: const TextStyle(color: Color(0xFFFFB703), fontSize: 13)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => setState(() {
              _status = '⏳ Sakrayapti...';
              _starKey = UniqueKey();
            }),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE94560)),
            child: const Text('⭐ Yulduzni sakrat', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
