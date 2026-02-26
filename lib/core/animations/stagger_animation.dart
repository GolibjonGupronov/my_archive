import 'package:flutter/material.dart';

/// StaggerAnimation - bir nechta elementni ketma-ket animatsiya qiladi
/// [onComplete] - barcha elementlar animatsiyasi tugagandan keyin chaqiriladi
class StaggerAnimation extends StatefulWidget {
  final List<Widget> children;
  final Duration itemDuration;
  final Duration staggerDelay;
  final VoidCallback? onComplete;

  const StaggerAnimation({
    super.key,
    required this.children,
    this.itemDuration = const Duration(milliseconds: 400),
    this.staggerDelay = const Duration(milliseconds: 100),
    this.onComplete,
  });

  @override
  State<StaggerAnimation> createState() => _StaggerAnimationState();
}

class _StaggerAnimationState extends State<StaggerAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnims;
  late List<Animation<Offset>> _slideAnims;

  @override
  void initState() {
    super.initState();
    final totalDuration = widget.itemDuration + widget.staggerDelay * (widget.children.length - 1);
    _controller = AnimationController(vsync: this, duration: totalDuration);

    _fadeAnims = List.generate(widget.children.length, (i) {
      final start = widget.staggerDelay.inMilliseconds * i / totalDuration.inMilliseconds;
      final end = (start + widget.itemDuration.inMilliseconds / totalDuration.inMilliseconds).clamp(0.0, 1.0);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(start, end, curve: Curves.easeOut)),
      );
    });

    _slideAnims = List.generate(widget.children.length, (i) {
      final start = widget.staggerDelay.inMilliseconds * i / totalDuration.inMilliseconds;
      final end = (start + widget.itemDuration.inMilliseconds / totalDuration.inMilliseconds).clamp(0.0, 1.0);
      return Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
        CurvedAnimation(parent: _controller, curve: Interval(start, end, curve: Curves.easeOut)),
      );
    });

    // Barcha animatsiyalar tugaganda onComplete chaqiriladi
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
    return Column(
      children: List.generate(widget.children.length, (i) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnims[i],
              child: SlideTransition(position: _slideAnims[i], child: child),
            );
          },
          child: widget.children[i],
        );
      }),
    );
  }
}

// ─── Demo ────────────────────────────────────────────────────────────────────

class StaggerAnimationDemo extends StatefulWidget {
  const StaggerAnimationDemo({super.key});

  @override
  State<StaggerAnimationDemo> createState() => _StaggerAnimationDemoState();
}

class _StaggerAnimationDemoState extends State<StaggerAnimationDemo> {
  Key _key = UniqueKey();
  String _status = '';

  final List<Map<String, dynamic>> _items = [
    {'icon': Icons.home, 'label': 'Bosh sahifa', 'color': Color(0xFFE94560)},
    {'icon': Icons.search, 'label': 'Qidirish', 'color': Color(0xFF0F3460)},
    {'icon': Icons.favorite, 'label': 'Sevimlilar', 'color': Color(0xFFFFB703)},
    {'icon': Icons.person, 'label': 'Profil', 'color': Color(0xFF4CAF50)},
    {'icon': Icons.settings, 'label': 'Sozlamalar', 'color': Color(0xFF9C27B0)},
  ];

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
          StaggerAnimation(
            key: _key,
            staggerDelay: const Duration(milliseconds: 120),
            onComplete: () => setState(() => _status = '✅ Barcha ${_items.length} element ko\'rsatildi! List tayyor.'),
            children: _items
                .map((item) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: (item['color'] as Color).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: (item['color'] as Color).withOpacity(0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(item['icon'] as IconData, color: item['color'] as Color, size: 24),
                          const SizedBox(width: 16),
                          Text(item['label'] as String, style: const TextStyle(color: Colors.white, fontSize: 16)),
                          const Spacer(),
                          Icon(Icons.chevron_right, color: (item['color'] as Color).withOpacity(0.7)),
                        ],
                      ),
                    ))
                .toList(),
          ),
          if (_status.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(_status, style: const TextStyle(color: Color(0xFFFFB703), fontSize: 13)),
            ),
          ElevatedButton.icon(
            onPressed: () => setState(() {
              _status = '⏳ Ketma-ket yuklanmoqda...';
              _key = UniqueKey();
            }),
            icon: const Icon(Icons.replay, color: Colors.white),
            label: const Text('Ketma-ket ko\'rsat', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F3460)),
          ),
        ],
      ),
    );
  }
}
