import 'package:flutter/material.dart';

/// RotationAnimation - elementni aylantirib ko'rsatadi
/// [onComplete] - animatsiya tugagandan keyin chaqiriladi (repeat=false bo'lsa)
class RotationAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double turns;
  final bool repeat;
  final bool reverse;
  final VoidCallback? onComplete;

  const RotationAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.turns = 1.0,
    this.repeat = false,
    this.reverse = false,
    this.onComplete,
  });

  @override
  State<RotationAnimation> createState() => _RotationAnimationState();
}

class _RotationAnimationState extends State<RotationAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: widget.turns).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    // onComplete faqat repeat=false bo'lganda ma'noli
    if (!widget.repeat) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete?.call();
        }
      });
    }

    if (widget.repeat) {
      _controller.repeat(reverse: widget.reverse);
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
    return RotationTransition(turns: _animation, child: widget.child);
  }
}

// ─── Demo ────────────────────────────────────────────────────────────────────

class RotationAnimationDemo extends StatefulWidget {
  const RotationAnimationDemo({super.key});

  @override
  State<RotationAnimationDemo> createState() => _RotationAnimationDemoState();
}

class _RotationAnimationDemoState extends State<RotationAnimationDemo> {
  Key _onceKey = UniqueKey();
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Doim aylanadi - onComplete yo'q (repeat=true)
              Column(children: [
                RotationAnimation(
                  repeat: true,
                  duration: const Duration(seconds: 3),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(colors: [Color(0xFFE94560), Color(0xFF0F3460), Color(0xFFE94560)]),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Doim', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ]),

              // Bir marta aylanadi - onComplete bor
              Column(children: [
                RotationAnimation(
                  key: _onceKey,
                  turns: 2.0,
                  // 720 daraja
                  duration: const Duration(seconds: 2),
                  onComplete: () => setState(() => _status = '✅ 720° tugadi! Sahifani yangilash mumkin.'),
                  child: const Icon(Icons.refresh, size: 55, color: Color(0xFFFFB703)),
                ),
                const SizedBox(height: 8),
                const Text('1 marta', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ]),

              // Teskari
              Column(children: [
                RotationAnimation(
                  repeat: true,
                  reverse: true,
                  duration: const Duration(seconds: 2),
                  child: const Icon(Icons.settings, size: 55, color: Color(0xFF4CAF50)),
                ),
                const SizedBox(height: 8),
                const Text('Teskari', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ]),
            ],
          ),
          const SizedBox(height: 12),
          if (_status.isNotEmpty) Text(_status, style: const TextStyle(color: Color(0xFFFFB703), fontSize: 13)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => setState(() {
              _status = '⏳ Aylanmoqda...';
              _onceKey = UniqueKey();
            }),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F3460)),
            child: const Text('🔄 Qayta ayla', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
