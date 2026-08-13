import 'package:flutter/material.dart';
import 'package:ebram_martina_wedding/utils/localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';



// ─────────────────────────────────────────────
// SECTION WRAPPER
// ─────────────────────────────────────────────
class DatePickerSection extends StatelessWidget {
  const DatePickerSection({
    super.key,
    required this.deviceType,
    required this.loc,
  });

  final DeviceType deviceType;
  final AppLocalizations loc;

  // the actual wedding day
  static const int weddingDay = 9;
  static const int weddingMonth = 10;
  static const int weddingYear = 2026;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          WeddingDateStrip(
            year: weddingYear,
            month: weddingMonth,
            highlightDay: weddingDay,
            loc: loc,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// WEDDING DATE STRIP — single row of days around the
// wedding date, matching the reference invitation card:
// cursive month/year label, thin-bordered day chips,
// a solid heart on the highlighted day, and a soft wavy
// gold line underneath.
// ─────────────────────────────────────────────

class WeddingDateStrip extends StatelessWidget {
  const WeddingDateStrip({
    super.key,
    required this.year,
    required this.month,
    required this.highlightDay,
    required this.loc,
    this.daysBefore = 2,
    this.daysAfter = 2,
  });

  final int year;
  final int month;
  final int highlightDay;
  final AppLocalizations loc;

  /// how many day-chips to show before/after the highlighted day
  final int daysBefore;
  final int daysAfter;

  int _daysInMonth(int y, int m) => DateTime(y, m + 1, 0).day;

  @override
  Widget build(BuildContext context) {
    final totalDays = _daysInMonth(year, month);

    final days = <int>[
      for (int d = highlightDay - daysBefore; d <= highlightDay + daysAfter; d++)
        if (d >= 1 && d <= totalDays) d,
    ];

    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 26,
      ),
      decoration: BoxDecoration(
        color: AppColors.paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.gold.withOpacity(.45),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withOpacity(.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Month / year label — elegant cursive script, like the invite
          Text(
            loc.monthYearLabel(month, year),
            style: GoogleFonts.greatVibes(
              fontSize: 30,
              color: AppColors.ink,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 22),

          // single row of days around the wedding date
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final day in days) ...[
                if (day != days.first) const SizedBox(width: 10),
                day == highlightDay
                    ? _PulsingHeartDay(
                  day: day,
                  fillColor: const Color(0xFFEEA1AB),
                  numberColor: AppColors.paper,
                )
                    : _DayChip(day: day),
              ],
            ],
          ),

          const SizedBox(height: 20),

          // soft wavy accent line, echoing the gold squiggle
          // under the highlighted date on the invitation
          SizedBox(
            width: 110,
            height: 16,
            child: CustomPaint(
              painter: _WavyLinePainter(color: AppColors.gold),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PLAIN DAY — small bordered square chip, like the
// "8 / 9 / 11 / 12" boxes in the reference image
// ─────────────────────────────────────────────
class _DayChip extends StatelessWidget {
  const _DayChip({required this.day});

  final int day;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.paper,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.sageLight,
          width: 1,
        ),
      ),
      child: Text(
        "$day",
        style: GoogleFonts.jost(
          fontSize: 13,
          color: AppColors.inkSoft,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PULSING HEART — custom-drawn shape with a slow,
// gentle heartbeat animation on the wedding day cell.
// ─────────────────────────────────────────────

class _PulsingHeartDay extends StatefulWidget {
  const _PulsingHeartDay({
    required this.day,
    required this.fillColor,
    required this.numberColor,
  });

  final int day;
  final Color fillColor;
  final Color numberColor;

  @override
  State<_PulsingHeartDay> createState() => _PulsingHeartDayState();
}

class _PulsingHeartDayState extends State<_PulsingHeartDay>
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

    // gentle beat: 1.0 -> 1.14 -> 1.0, eased like a real pulse
    // rather than a linear bounce
    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.14)
            .chain(CurveTween(curve: Curves.easeOutSine)),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.14, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInSine)),
        weight: 55,
      ),
    ]).animate(_controller);
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
      child: SizedBox(
        width: 40,
        height: 38,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size(40, 36),
              painter: _HeartPainter(
                fillColor: widget.fillColor,
                highlightColor: widget.numberColor.withOpacity(.16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                "${widget.day}",
                style: GoogleFonts.jost(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: widget.numberColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Hand-drawn-style heart shape (Bezier curves), used instead of the
/// default Material `Icons.favorite` glyph so it matches the
/// invitation's illustrated look — includes a soft inner highlight
/// for a bit of dimension instead of a flat icon fill.
class _HeartPainter extends CustomPainter {
  _HeartPainter({
    required this.fillColor,
    required this.highlightColor,
  });

  final Color fillColor;
  final Color highlightColor;

  Path _heartPath(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    path.moveTo(w * 0.5, h * 0.98);
    path.cubicTo(
      w * -0.05, h * 0.62,
      w * 0.05, h * 0.02,
      w * 0.5, h * 0.26,
    );
    path.cubicTo(
      w * 0.95, h * 0.02,
      w * 1.05, h * 0.62,
      w * 0.5, h * 0.98,
    );
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = _heartPath(size);

    canvas.drawPath(path, Paint()..color = fillColor);

    // a soft light patch near the top-left lobe so the heart doesn't
    // read as a completely flat block of color
    final highlight = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width * 0.32, size.height * 0.28),
        radius: size.width * 0.16,
      ));
    canvas.save();
    canvas.clipPath(path);
    canvas.drawPath(highlight, Paint()..color = highlightColor);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _HeartPainter oldDelegate) {
    return oldDelegate.fillColor != fillColor ||
        oldDelegate.highlightColor != highlightColor;
  }
}

// ─────────────────────────────────────────────
// WAVY DECORATIVE LINE — the thin gold squiggle under
// the row, echoing the hand-drawn line on the card
// ─────────────────────────────────────────────
class _WavyLinePainter extends CustomPainter {
  _WavyLinePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    final path = Path()..moveTo(0, size.height * 0.5);

    path.cubicTo(
      size.width * 0.25, 0,
      size.width * 0.35, size.height,
      size.width * 0.5, size.height * 0.5,
    );
    path.cubicTo(
      size.width * 0.65, 0,
      size.width * 0.75, size.height,
      size.width, size.height * 0.5,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavyLinePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}