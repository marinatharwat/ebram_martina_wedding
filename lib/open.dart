import 'dart:html' as html;
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:ebram_martina_wedding/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CurtainScreen extends StatefulWidget {
  final void Function(html.AudioElement audio) onOpen;

  const CurtainScreen({
    super.key,
    required this.onOpen,
  });

  @override
  State<CurtainScreen> createState() => _CurtainScreenState();
}

class _CurtainScreenState extends State<CurtainScreen>
    with SingleTickerProviderStateMixin {
  // ---- Palette ----
  static const Color cream = Color(0xFFFEF6F2);
  static const Color ribbonPale = Color(0xFFEFC9C2);
  static const Color ribbon = Color(0xFFA83A34);
  static const Color ribbonDeep = Color(0xFF7E2620);
  static const Color inkSoft = Color(0xFF6B3B33);
  static const Color titleDark = Color(0xFF3A1512);

  bool _opened = false;
  html.AudioElement? _audio;

  late AnimationController _heartsController;

  @override
  void initState() {
    super.initState();

    // Subtle floating animation for the hearts
    _heartsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _audio = html.AudioElement()
      ..src = 'assets/assets/audio/special_message.mp3'
      ..preload = 'auto'
      ..volume = 1.0;
  }

  void _open() {
    if (_opened) return;

    setState(() => _opened = true);

    _audio?.play().catchError(
          (e) => debugPrint('Play error: $e'),
    );

    widget.onOpen(_audio!);
  }

  @override
  void dispose() {
    _heartsController.dispose();

    if (_opened) {
      // الصوت اتبعت للـ parent — متمسهوش هنا
    } else {
      _audio?.pause();
      _audio?.src = '';
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: _open,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background blur
            BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 6,
                sigmaY: 6,
              ),
              child: Container(
                color: cream.withOpacity(0.25),
              ),
            ),

            // Soft vertical ribbon glow
            Center(
              child: Container(
                width: 0.8,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ribbon.withOpacity(0.0),
                      ribbon.withOpacity(0.7),
                      ribbon.withOpacity(0.0),
                    ],
                    stops: const [
                      0.0,
                      0.5,
                      1.0,
                    ],
                  ),
                ),
              ),
            ),

            // Floating animated hearts
            ..._buildFloatingHearts(size),

            // Main circle
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cream.withOpacity(0.95),
                  border: Border.all(
                    color: ribbonPale.withOpacity(0.8),
                    width: 1.4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ribbonDeep.withOpacity(0.16),
                      blurRadius: 26,
                      spreadRadius: 6,
                    ),
                    BoxShadow(
                      color: ribbon.withOpacity(0.2),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.rosee,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      ' Ebram & Martina ',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: titleDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 10),
                    Text(
                      'Tap to Open',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 10,
                        letterSpacing: 2,
                        color: inkSoft.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Floating animated hearts
  // ------------------------------------------------------------

  List<Widget> _buildFloatingHearts(Size size) {
    final hearts = <Map<String, double>>[
      {
        'x': 0.18,
        'y': 0.25,
        'size': 12.0,
        'opacity': 0.22,
        'delay': 0.00,
      },
      {
        'x': 0.29,
        'y': 0.18,
        'size': 8.0,
        'opacity': 0.18,
        'delay': 0.20,
      },
      {
        'x': 0.42,
        'y': 0.28,
        'size': 10.0,
        'opacity': 0.24,
        'delay': 0.40,
      },
      {
        'x': 0.70,
        'y': 0.22,
        'size': 11.0,
        'opacity': 0.22,
        'delay': 0.10,
      },
      {
        'x': 0.82,
        'y': 0.30,
        'size': 8.0,
        'opacity': 0.18,
        'delay': 0.50,
      },
      {
        'x': 0.23,
        'y': 0.43,
        'size': 9.0,
        'opacity': 0.20,
        'delay': 0.30,
      },
      {
        'x': 0.78,
        'y': 0.44,
        'size': 12.0,
        'opacity': 0.20,
        'delay': 0.60,
      },
      {
        'x': 0.16,
        'y': 0.62,
        'size': 10.0,
        'opacity': 0.18,
        'delay': 0.40,
      },
      {
        'x': 0.29,
        'y': 0.73,
        'size': 8.0,
        'opacity': 0.22,
        'delay': 0.10,
      },
      {
        'x': 0.72,
        'y': 0.67,
        'size': 10.0,
        'opacity': 0.20,
        'delay': 0.50,
      },
      {
        'x': 0.84,
        'y': 0.73,
        'size': 8.0,
        'opacity': 0.17,
        'delay': 0.25,
      },
      {
        'x': 0.50,
        'y': 0.80,
        'size': 11.0,
        'opacity': 0.18,
        'delay': 0.70,
      },
    ];

    return List.generate(
      hearts.length,
          (i) {
        final heart = hearts[i];

        return AnimatedBuilder(
          animation: _heartsController,
          builder: (context, child) {
            final progress =
                (_heartsController.value + heart['delay']!) % 1.0;

            // حركة بسيطة لأعلى وأسفل
            final dy = -7 * math.sin(
              progress * math.pi * 2,
            );

            // Fade خفيف وناعم
            final opacity = heart['opacity']! *
                (0.75 +
                    0.25 *
                        math.sin(
                          progress * math.pi,
                        ));

            // ميلان بسيط جدًا للقلب
            final rotation = 0.12 *
                math.sin(
                  progress * math.pi * 2,
                );

            return Positioned(
              left: size.width * heart['x']!,
              top: size.height * heart['y']! + dy,
              child: Opacity(
                opacity: opacity.clamp(0.0, 1.0),
                child: Transform.rotate(
                  angle: rotation,
                  child: Icon(
                    Icons.favorite,
                    size: heart['size'],
                    color: ribbon,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}