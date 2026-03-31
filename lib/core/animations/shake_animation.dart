import 'dart:math';

import 'package:flutter/material.dart';

class ShakeController {
  VoidCallback? _shake;

  void _bind(VoidCallback shake) {
    _shake = shake;
  }

  void shake() {
    _shake?.call();
  }
}

/// ShakeAnimation - elementni chayqatib ko'rsatadi (xato holatda)
/// [onComplete] - animatsiya tugagandan keyin chaqiriladi
class ShakeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double shakeOffset;
  final int shakeCount;
  final VoidCallback? onComplete;
  final VoidCallback? onStart;
  final ShakeController? controller;

  const ShakeAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.shakeOffset = 10.0,
    this.shakeCount = 4,
    this.onComplete,
    this.onStart,
    this.controller,
  });

  @override
  State<ShakeAnimation> createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    widget.controller?._bind(_startShake);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      } else if (status == AnimationStatus.forward) {
        widget.onStart?.call();
      }
    });

    // _controller.forward();
  }

  void _startShake() {
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _shakeOffset(double t) {
    return widget.shakeOffset * sin(t * pi * widget.shakeCount * 2) * (1 - t);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeOffset(_animation.value), 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

// ─── Demo ────────────────────────────────────────────────────────────────────

class ShakeAnimationDemo extends StatefulWidget {
  const ShakeAnimationDemo({super.key});

  @override
  State<ShakeAnimationDemo> createState() => _ShakeAnimationDemoState();
}

class _ShakeAnimationDemoState extends State<ShakeAnimationDemo> {
  Key _key = UniqueKey();
  bool _showError = false;
  String _status = '';

  void _shake() {
    setState(() {
      _showError = true;
      _key = UniqueKey();
      _status = '⏳ Chayqalmoqda...';
    });
  }

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
          ShakeAnimation(
            key: _key,
            onComplete: () => setState(() {
              _showError = false;
              _status = '✅ Chayqatish tugadi! Foydalanuvchi xabardor qilindi.';
            }),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _showError ? const Color(0xFFE94560).withOpacity(0.2) : const Color(0xFF0F3460),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _showError ? const Color(0xFFE94560) : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _showError ? Icons.error_outline : Icons.lock_outline,
                    color: _showError ? const Color(0xFFE94560) : Colors.white54,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _showError ? 'Noto\'g\'ri parol! ❌' : 'Parol kiriting...',
                    style: TextStyle(
                      color: _showError ? const Color(0xFFE94560) : Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (_status.isNotEmpty) Text(_status, style: const TextStyle(color: Color(0xFFFFB703), fontSize: 13)),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _shake,
            icon: const Icon(Icons.vibration, color: Colors.white),
            label: const Text('Chayqat (Xato simulyatsiya)', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE94560)),
          ),
        ],
      ),
    );
  }
}
