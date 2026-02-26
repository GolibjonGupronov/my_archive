import 'package:flutter/material.dart';

/// ScaleAnimation - elementni kichikdan kattaga o'stirib ko'rsatadi
/// [onComplete] - animatsiya tugagandan keyin chaqiriladi
class ScaleAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double beginScale;
  final double endScale;
  final Curve curve;
  final VoidCallback? onComplete;

  const ScaleAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.beginScale = 0.0,
    this.endScale = 1.0,
    this.curve = Curves.elasticOut,
    this.onComplete,
  });

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scaleAnim = Tween<double>(begin: widget.beginScale, end: widget.endScale)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));

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
    return ScaleTransition(scale: _scaleAnim, child: widget.child);
  }
}

// ─── Demo ────────────────────────────────────────────────────────────────────

class ScaleAnimationDemo extends StatefulWidget {
  const ScaleAnimationDemo({super.key});

  @override
  State<ScaleAnimationDemo> createState() => _ScaleAnimationDemoState();
}

class _ScaleAnimationDemoState extends State<ScaleAnimationDemo> {
  Key _key = UniqueKey();
  String _curveLabel = 'elasticOut';
  Curve _curve = Curves.elasticOut;
  String _status = '';

  final Map<String, Curve> _curves = {
    'elasticOut': Curves.elasticOut,
    'bounceOut': Curves.bounceOut,
    'easeOutBack': Curves.easeOutBack,
    'easeOut': Curves.easeOut,
  };

  void _replay(String label, Curve curve) {
    setState(() {
      _curveLabel = label;
      _curve = curve;
      _key = UniqueKey();
      _status = '⏳ Kattayyapti...';
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
          SizedBox(
            height: 100,
            child: Center(
              child: ScaleAnimation(
                key: _key,
                curve: _curve,
                duration: const Duration(milliseconds: 800),
                onComplete: () => setState(() => _status = '✅ Scale tugadi! To\'liq ko\'rinmoqda.'),
                child: Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFFE94560), Color(0xFFFFB703)]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.star, size: 40, color: Colors.white),
                ),
              ),
            ),
          ),
          if (_status.isNotEmpty) Text(_status, style: const TextStyle(color: Color(0xFFFFB703), fontSize: 13)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _curves.entries
                .map((e) => GestureDetector(
                      onTap: () => _replay(e.key, e.value),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: _curveLabel == e.key ? const Color(0xFFE94560) : const Color(0xFF0F3460),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(e.key, style: const TextStyle(color: Colors.white, fontSize: 11)),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
