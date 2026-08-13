import 'dart:async';
import 'dart:math' as math;
import 'package:ebram_martina_wedding/theme/app_theme.dart';
import 'package:ebram_martina_wedding/utils/localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Wedding date: Friday, 9 October 2026
final DateTime weddingDate = DateTime(2026, 10, 9);

/// Fractional (x, y) position of each of the 4 gold hook rings in
/// "plant.png", measured against the image's own width/height
/// (0.0–1.0 on both axes). Order matches DAYS, HOURS, MIN, SEC.
const List<Offset> _hookAnchors = [
  Offset(0.203, 0.605),
  Offset(0.416, 0.605),
  Offset(0.597, 0.605),
  Offset(0.811, 0.605),
];

/// Extra downward nudge per tag, as a fraction of the image height,
/// added on top of `_hookAnchors`. HOURS and SEC sit a bit lower here
/// so they line up with where the vine actually dips on your asset —
/// raise/lower these numbers (or add entries for DAYS/MIN) until every
/// tag top touches its own hook exactly.
const List<double> _hookVerticalNudge = [0.0, 0.035, 0.035, 0.0];

// Native aspect ratio of plant.png (width / height). Update this if
// you swap in an asset with different proportions — getting this
// right (rather than the box) is what prevents any cropping.
const double _plantAspectRatio = 1230 / 868;

/// Recreates the hanging-tag countdown using the real "plant.png"
/// garland illustration instead of a hand-drawn vine. `loc` follows
/// the same shape used across HeroSection/DatePickerSection
/// (loc.heroCountdownTitle, loc.unitDays, loc.unitHours,
/// loc.unitMinutes, loc.unitSeconds, loc.countdownDate).
class WeddingCountdownGarland extends StatefulWidget {
  const WeddingCountdownGarland({
    super.key,
    this.targetDate,
    this.loc,
    this.plantAsset = 'assets/images/plant.png',
  });

  final DateTime? targetDate;
  final AppLocalizations? loc;

  /// Path to the garland image. Make sure it's declared under
  /// `flutter: assets:` in pubspec.yaml.
  final String plantAsset;

  @override
  State<WeddingCountdownGarland> createState() =>
      _WeddingCountdownGarlandState();
}

class _WeddingCountdownGarlandState extends State<WeddingCountdownGarland> {
  late Timer _timer;
  late Duration _remaining;
  late DateTime _target;

  // ── FIX #2: don't paint on the very first (often bogus) layout
  // pass. In-app WebViews (Messenger, Instagram, etc. on Android)
  // frequently report a wrong/narrow viewport width on the first
  // frame or two before settling on the real one. Painting
  // immediately bakes that wrong width into the countdown's layout
  // and shows briefly as horizontal overflow ("text escaping the
  // container"). Waiting one frame + a short delay lets the WebView
  // settle before we ever compute `w`.
  bool _readyToRender = false;

  @override
  void initState() {
    super.initState();
    _target = widget.targetDate ?? weddingDate;
    _remaining = _calculateRemaining();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) => setState(() => _remaining = _calculateRemaining()),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 80), () {
        if (mounted) setState(() => _readyToRender = true);
      });
    });
  }

  Duration _calculateRemaining() {
    final diff = _target.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _two(int v) => v.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final loc = widget.loc ?? const AppLocalizations('en');

    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;
    final values = [_two(days), _two(hours), _two(minutes), _two(seconds)];
    final labels = [
      loc.unitDays,
      loc.unitHours,
      loc.unitMinutes,
      loc.unitSeconds,
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // ── FIX #2 (cont.): show nothing (zero height) until the
        // layout has had a moment to settle. This avoids a visible
        // "flash" of an overflowed/garbled countdown on first paint
        // inside in-app browsers.
        if (!_readyToRender) {
          return const SizedBox.shrink();
        }

        // ── FIX #1: lowered the minimum clamp from 240 -> 160.
        // Some in-app WebViews (Messenger's Android WebView chief
        // among them) can report a `constraints.maxWidth` narrower
        // than 240 on early frames. The old clamp forced `w` to stay
        // at 240 regardless, so the widget rendered WIDER than the
        // actual available space -> horizontal overflow. 160 is a
        // safer floor that still keeps the tags legible.
        final w = (constraints.maxWidth - 24).clamp(160.0, 900.0);

        final plantHeight = w / _plantAspectRatio;

        final tagWidth = (w * 0.16).clamp(52.0, 130.0);
        final tagHeight = tagWidth * 1.48;
        final stringLen = tagHeight * 0.16;

        final maxHookFraction = List<double>.generate(
          _hookAnchors.length,
              (i) => _hookAnchors[i].dy + _hookVerticalNudge[i],
        ).reduce(math.max);
        final tagsBottom = plantHeight * maxHookFraction + tagHeight;
        final stackHeight = math.max(plantHeight, tagsBottom);

        // ── FIX #3: safety-net clip. Even with fixes #1 and #2,
        // wrap the whole block in a ClipRect tied to the *actual*
        // available width (constraints.maxWidth), not just the
        // image's own bounds. If any measurement is ever off by a
        // few pixels on a weird WebView, content gets clipped
        // instead of visibly spilling outside the screen.
        return ClipRect(
          child: Container(
            width: double.infinity,
            color: Colors.transparent,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                CountingDownHeader(
                  width: 0.20,
                  loc: loc,
                ),
                Transform.translate(
                  offset: const Offset(0, -35),
                  child: SizedBox(
                    width: w,
                    height: stackHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          width: w,
                          height: plantHeight,
                          child: Center(
                            child: Image.asset(
                              widget.plantAsset,
                              width: w,
                              height: plantHeight,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        for (int i = 0; i < 4; i++)
                          Positioned(
                            left: w * _hookAnchors[i].dx - tagWidth / 2,
                            top: plantHeight *
                                (_hookAnchors[i].dy + _hookVerticalNudge[i]),
                            width: tagWidth,
                            child: _HangingTag(
                              value: values[i],
                              label: labels[i],
                              width: tagWidth,
                              height: tagHeight,
                              stringLength: stringLen,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: SizedBox(
                      child: Text(
                        loc.countdownDate,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: (w * 0.03).clamp(15.0, 22.0),
                          letterSpacing: 3,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ink,
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// HANGING TAG
// ─────────────────────────────────────────────

class _HangingTag extends StatelessWidget {
  const _HangingTag({
    required this.value,
    required this.label,
    required this.width,
    required this.height,
    required this.stringLength,
  });

  final String value;
  final String label;
  final double width;
  final double height;
  final double stringLength;

  @override
  Widget build(BuildContext context) {
    final cut = (width * 0.11).clamp(8.0, 16.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipPath(
          clipper: _TagClipper(cut: cut),
          child: Container(
            width: width,
            height: height,
            color: AppColors.cream,
            padding: EdgeInsets.symmetric(
              vertical: height * 0.09,
              horizontal: width * 0.06,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: width * 0.42,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.05),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: width * 0.16,
                        height: 0.8,
                        color: AppColors.gold),
                    SizedBox(width: width * 0.03),
                    Transform.rotate(
                      angle: math.pi / 4,
                      child:
                      Container(width: 5, height: 5, color: AppColors.gold),
                    ),
                    SizedBox(width: width * 0.03),
                    Container(
                        width: width * 0.16,
                        height: 0.8,
                        color: AppColors.gold),
                  ],
                ),
                SizedBox(height: height * 0.05),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: width * 0.18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.inkSoft,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TagClipper extends CustomClipper<Path> {
  _TagClipper({required this.cut});

  final double cut;

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path()
      ..moveTo(cut, 0)
      ..lineTo(w - cut, 0)
      ..lineTo(w, cut)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..lineTo(0, cut)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant _TagClipper oldClipper) => oldClipper.cut != cut;
}

// small gold/rose heart used above the title and in the date row
class _HeartPainter extends CustomPainter {
  _HeartPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.5, h * 0.98)
      ..cubicTo(w * -0.05, h * 0.62, w * 0.05, h * 0.02, w * 0.5, h * 0.26)
      ..cubicTo(w * 0.95, h * 0.02, w * 1.05, h * 0.62, w * 0.5, h * 0.98)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────
// small flourish divider (sprigs + diamond/heart)
// ─────────────────────────────────────────────

const String kLeafAsset = 'assets/images/leaf.png';

/// "Counting down / TO OUR FOREVER" header with a leaf sprig on each
/// side. Both leaves use the SAME image file — the right one is just
/// the left one mirrored with Transform.flip, so you only need to
/// import the asset once.
class CountingDownHeader extends StatelessWidget {
  const CountingDownHeader({
    super.key,
    required this.width,
    this.loc,
    this.leafAsset = kLeafAsset,
  });

  final double width;
  final AppLocalizations? loc;
  final String leafAsset;

  @override
  Widget build(BuildContext context) {
    final effectiveLoc = loc ?? const AppLocalizations('en');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _PulsingHeart(),
              const SizedBox(height: 4),
              Text(
                effectiveLoc.heroCountdownTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: AppColors.terracotta,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                effectiveLoc.heroCountdownSubtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: (width * 0.026).clamp(16.0, 24.0),
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PulsingHeart extends StatefulWidget {
  const _PulsingHeart();

  @override
  State<_PulsingHeart> createState() => _PulsingHeartState();
}

class _PulsingHeartState extends State<_PulsingHeart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 0.85,
      end: 1.15,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: CustomPaint(
        size: const Size(16, 14),
        painter: _HeartPainter(
          color: AppColors.gold,
        ),
      ),
    );
  }
}