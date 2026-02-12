import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

// Pin animado no mapa
class AnimatedBookPin extends StatefulWidget {
  final Book book;
  final Duration delay;

  const AnimatedBookPin({super.key, required this.book, required this.delay});

  @override
  State<AnimatedBookPin> createState() => _AnimatedBookPinState();
}

class _AnimatedBookPinState extends State<AnimatedBookPin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Delay inicial e loop
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(scale: _scaleAnimation.value, child: child);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Círculo com capa
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(
                    alpha: AppDimensions.opacityMedium,
                  ),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: BookCover(
                coverUrl: widget.book.coverUrl,
                width: 44,
                height: 44,
                fallbackText: null, // Sem texto em pins pequenos
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          // Seta
          CustomPaint(
            size: const Size(14, 10),
            painter: _TrianglePainter(AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
