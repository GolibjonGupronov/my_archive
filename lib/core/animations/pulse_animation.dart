import 'package:flutter/material.dart';

/// PulseAnimation - elementni yurak urishi kabi pulsatsiya qildirib ko'rsatadi
/// [repeatCount] - necha marta pulsatsiya qilish (0 = cheksiz)
/// [onComplete] - [repeatCount] marta bo'lgandan keyin chaqiriladi
class PulseAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;
  final int repeatCount; // 0 = cheksiz
  final VoidCallback? onComplete;

  const PulseAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.minScale = 0.95,
    this.maxScale = 1.05,
    this.repeatCount = 0,
    this.onComplete,
  });

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: widget.minScale, end: widget.maxScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.repeatCount > 0) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _count++;
          if (_count >= widget.repeatCount) {
            widget.onComplete?.call();
          } else {
            _controller.reverse();
          }
        } else if (status == AnimationStatus.dismissed && _count < widget.repeatCount) {
          _controller.forward();
        }
      });
      _controller.forward();
    } else {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.child);
  }
}

// ─── Demo ────────────────────────────────────────────────────────────────────

class PulseAnimationDemo extends StatefulWidget {
  const PulseAnimationDemo({super.key});

  @override
  State<PulseAnimationDemo> createState() => _PulseAnimationDemoState();
}

class _PulseAnimationDemoState extends State<PulseAnimationDemo> {
  Key _btnKey = UniqueKey();
  String _status = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Cheksiz pulsatsiya
              Column(children: [
                PulseAnimation(
                  minScale: 0.85,
                  maxScale: 1.15,
                  duration: const Duration(milliseconds: 800),
                  child: const Icon(Icons.favorite, color: Color(0xFFE94560), size: 50),
                ),
                const SizedBox(height: 8),
                const Text('Cheksiz', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ]),

              // 3 marta pulse -> onComplete
              Column(children: [
                PulseAnimation(
                  key: _btnKey,
                  minScale: 0.92,
                  maxScale: 1.08,
                  duration: const Duration(milliseconds: 700),
                  repeatCount: 3,
                  onComplete: () => setState(() => _status = '✅ 3 marta tugadi! E\'tibor jalb etildi.'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF0F3460), Color(0xFFE94560)]),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE94560).withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Text('CLICK ME',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('3 marta', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ]),

              // Dot
              Column(children: [
                PulseAnimation(
                  minScale: 0.7,
                  maxScale: 1.3,
                  duration: const Duration(milliseconds: 1200),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFB703),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Color(0xFFFFB703), blurRadius: 10, spreadRadius: 2),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Dot', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ]),
            ],
          ),
          const SizedBox(height: 12),
          if (_status.isNotEmpty) Text(_status, style: const TextStyle(color: Color(0xFFFFB703), fontSize: 13)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => setState(() {
              _status = '⏳ 3 marta pulsatsiya...';
              _btnKey = UniqueKey();
            }),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F3460)),
            child: const Text('▶ Qayta (3 marta)', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
