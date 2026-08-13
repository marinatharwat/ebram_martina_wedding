import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ebram_martina_wedding/theme/app_theme.dart';
import 'package:ebram_martina_wedding/utils/localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class MomentoInstagramWidget extends StatefulWidget {

  final AppLocalizations? loc;

  const MomentoInstagramWidget({super.key,  required this.loc,
  });

  @override
  State<MomentoInstagramWidget> createState() => _MomentoInstagramWidgetState();
}

class _MomentoInstagramWidgetState extends State<MomentoInstagramWidget> {
  bool _pressed = false;

  Future<void> _openInstagram() async {
    if (kIsWeb) {
      await launchUrl(
        Uri.parse('https://www.instagram.com/memento.511/'),
        webOnlyWindowName: '_self',
        mode: LaunchMode.platformDefault,
      );
    } else {
      final uri = Uri.parse('https://www.instagram.com/memento.511/');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.loc!.followOurWork,
          style:  TextStyle(
            fontSize: 10,
            color:AppColors.gold,
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(height: 14),

        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) {
            setState(() => _pressed = false);
            _openInstagram();
          },

    onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: _pressed
                  ? Color(0xFFFBF3EC)
                  : Color(0xFFFBF3EC),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color:AppColors.ink,
                width: 0.8,
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _InstagramIcon(),
                SizedBox(width: 8),
                Text(
                  '@memento.511',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.ink,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'v3.0.0',
            style: TextStyle(
              fontSize: 9,
              letterSpacing: 1.5,
              color: AppColors.ink,
            ),
          ),
        ),
      ],
    );
  }
}


class _InstagramIcon extends StatelessWidget {
  const _InstagramIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(16, 16),
      painter: _InstagramPainter(),
    );
  }
}

class _InstagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =   AppColors.ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final s = size.width;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(s * 0.08, s * 0.08, s * 0.84, s * 0.84),
        Radius.circular(s * 0.22),
      ),
      paint,
    );

    canvas.drawCircle(
      Offset(s * 0.5, s * 0.5),
      s * 0.22,
      paint,
    );

    canvas.drawCircle(
      Offset(s * 0.73, s * 0.27),
      s * 0.04,
      paint..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}