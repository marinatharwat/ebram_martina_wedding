import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

/// Clips a widget into a proper symmetric heart shape.
class HeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return _heartPath(size);
  }

  @override
  bool shouldReclip(_) => false;
}

Path _heartPath(Size size) {
  final w = size.width;
  final h = size.height;
  final path = Path();

  // Bottom tip
  path.moveTo(w * 0.5, h * 0.95);

  // Left side — up to left bump
  path.cubicTo(
    w * 0.05, h * 0.65,
    w * -0.10, h * 0.30,
    w * 0.20, h * 0.10,
  );

  // Left bump top
  path.cubicTo(
    w * 0.35, h * -0.05,
    w * 0.50, h * 0.15,
    w * 0.50, h * 0.30,
  );

  // Right bump top
  path.cubicTo(
    w * 0.50, h * 0.15,
    w * 0.65, h * -0.05,
    w * 0.80, h * 0.10,
  );

  // Right side — down to tip
  path.cubicTo(
    w * 1.10, h * 0.30,
    w * 0.95, h * 0.65,
    w * 0.50, h * 0.95,
  );

  path.close();
  return path;
}

/// Draws only the heart outline (stroke, no fill).
class _HeartBorderPainter extends CustomPainter {
  const _HeartBorderPainter({
    required this.color,
    required this.strokeWidth,
  });

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      _heartPath(size),
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_HeartBorderPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}

/// A heart-shaped day card used in the date picker section.
class DayCard extends StatelessWidget {
  const DayCard({
    super.key,
    required this.dayOfWeek,
    required this.dayNumber,
    required this.selected,
    required this.onTap,
    this.width = 88,
  });

  final String dayOfWeek;
  final int dayNumber;
  final bool selected;
  final VoidCallback onTap;
  final double width;

  // Taller than wide so the heart has natural proportions
  double get _height => width * 1.05;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 220),
        offset: selected ? const Offset(0, -0.10) : Offset.zero,
        curve: Curves.easeOut,
        child: SizedBox(
          width: width,
          height: _height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // ── Heart fill ──────────────────────────────────────────────
              Positioned.fill(
                child: ClipPath(
                  clipper: HeartClipper(),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    color: selected
                        ? AppColors.crimson.withOpacity(0.09)
                        : AppColors.paper,
                  ),
                ),
              ),

              // ── Heart border ────────────────────────────────────────────
              Positioned.fill(
                child: CustomPaint(
                  painter: _HeartBorderPainter(
                    color: selected ? AppColors.crimson : AppColors.rose,
                    strokeWidth: 1.6,
                  ),
                ),
              ),

              // ── Shadow when selected ────────────────────────────────────
              if (selected)
                Positioned(
                  bottom: -6,
                  child: Container(
                    width: width * 0.5,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

              // ── Day text + number ───────────────────────────────────────
              // Centered in the lower-middle zone of the heart body
              Positioned(
                top: _height * 0.32,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      dayOfWeek.toUpperCase(),
                      style: GoogleFonts.jost(
                        fontSize: 10,
                        letterSpacing: 1,
                        color: AppColors.inkSoft,
                      ),
                    ),
                    Text(
                      '$dayNumber',
                      style: GoogleFonts.marcellus(
                        fontSize: 26,
                        color: selected ? AppColors.crimson : AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}