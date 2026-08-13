import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Stand-in for the couple's photo. Real apps would swap [imageProvider] in —
/// until then this paints a soft duotone silhouette so the layout, colours
/// and composition can be reviewed without needing a real photo.
class PhotoFramePlaceholder extends StatelessWidget {
  const PhotoFramePlaceholder({
    super.key,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(100),
      topRight: Radius.circular(100),
      bottomLeft: Radius.circular(26),
      bottomRight: Radius.circular(26),
    ),
    this.imageProvider,
  });

  final BorderRadius borderRadius;
  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF6CDD6), Color(0xFFEEA9BB)],
          ),
          image: imageProvider != null
              ? DecorationImage(image: imageProvider!, fit: BoxFit.cover)
              : null,
        ),
        child: imageProvider == null
            ? CustomPaint(painter: _SilhouettePainter())
            : null,
      ),
    );
  }
}

class _SilhouettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final a = Paint()..color = AppColors.inkSoft.withOpacity(.5);
    final b = Paint()..color = AppColors.crimsonDeep.withOpacity(.55);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * .38, size.height * .98),
        width: size.width * .55,
        height: size.height * .68,
      ),
      a,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * .63, size.height * .98),
        width: size.width * .58,
        height: size.height * .72,
      ),
      b,
    );
    canvas.drawCircle(
      Offset(size.width * .41, size.height * .54),
      size.width * .12,
      b,
    );
    canvas.drawCircle(
      Offset(size.width * .60, size.height * .51),
      size.width * .13,
      a,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
