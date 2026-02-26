import 'package:flutter/material.dart';

/// SlideAnimation - elementni bir tomondan siljitib keladi
/// [onComplete] - animatsiya tugagandan keyin chaqiriladi
class SlideAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final SlideDirection direction;
  final VoidCallback? onComplete;

  const SlideAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.direction = SlideDirection.fromLeft,
    this.onComplete,
  });

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

enum SlideDirection { fromLeft, fromRight, fromTop, fromBottom }

class _SlideAnimationState extends State<SlideAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  Offset _getBeginOffset() {
    switch (widget.direction) {
      case SlideDirection.fromLeft:
        return const Offset(-1.0, 0.0);
      case SlideDirection.fromRight:
        return const Offset(1.0, 0.0);
      case SlideDirection.fromTop:
        return const Offset(0.0, -1.0);
      case SlideDirection.fromBottom:
        return const Offset(0.0, 1.0);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<Offset>(begin: _getBeginOffset(), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

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
    return SlideTransition(position: _animation, child: widget.child);
  }
}

// ─── Demo ────────────────────────────────────────────────────────────────────

class SlideAnimationDemo extends StatefulWidget {
  const SlideAnimationDemo({super.key});

  @override
  State<SlideAnimationDemo> createState() => _SlideAnimationDemoState();
}

class _SlideAnimationDemoState extends State<SlideAnimationDemo> {
  SlideDirection _direction = SlideDirection.fromLeft;
  Key _key = UniqueKey();
  String _status = '';

  void _replay(SlideDirection dir) {
    setState(() {
      _direction = dir;
      _key = UniqueKey();
      _status = '⏳ Siljiyapti...';
    });
  }

  @override
  Widget build(BuildContext context) {
    final dirs = {
      '⬅ Chapdan': SlideDirection.fromLeft,
      '➡ O\'ngdan': SlideDirection.fromRight,
      '⬆ Tepadan': SlideDirection.fromTop,
      '⬇ Pastdan': SlideDirection.fromBottom,
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ClipRect(
            child: SlideAnimation(
              key: _key,
              direction: _direction,
              onComplete: () => setState(() => _status = '✅ Slide tugadi! Element o\'z joyida.'),
              child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F3460),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('🚀 Men sirpanib keldim!', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (_status.isNotEmpty) Text(_status, style: const TextStyle(color: Color(0xFFFFB703), fontSize: 13)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: dirs.entries
                .map((e) => ElevatedButton(
                      onPressed: () => _replay(e.value),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F3460),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      child: Text(e.key, style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
