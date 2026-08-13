import 'package:ebram_martina_wedding/utils/localizations.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';


class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.deviceType,
    required this.onChevronTap,
    required this.loc,
  });

  final DeviceType deviceType;
  final VoidCallback onChevronTap;
  final AppLocalizations loc;

  bool get _isDesktop => deviceType == DeviceType.desktop;

  bool get _isArabic => loc.isArabic;

  @override
  Widget build(BuildContext context) {
    final fontFamily = _isArabic ? 'Amiri' : 'CormorantGaramond';

    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Center(
        child: Container(
          width: _isDesktop ? 650 : 380,
          padding: EdgeInsets.symmetric(
            horizontal: _isDesktop ? 30 : 18,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/b.png"),
              // ============================================================
              // TOP TITLE
              // ============================================================

              Text(
                loc.youAreInvited,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: _isDesktop ? 43 : 32,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  color: AppColors.ink,
                ),
              ),

              // ============================================================
              // VERSE
              // ============================================================

              SizedBox(
                height: _isDesktop ? 20 : 15,
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _isDesktop ? 45 : 20,
                ),
                child: Column(
                  children: [
                    _PulsingHeartDivider(isDesktop: _isDesktop),

                    SizedBox(
                      height: _isDesktop ? 14 : 10,
                    ),

                    Text(
                      loc.heroEyebrow.split('\n').first,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: _isDesktop ? 18 : 15,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        height: 1.65,
                        letterSpacing: _isArabic ? 0 : 0.2,
                        color: AppColors.olive,
                      ),
                    ),

                    SizedBox(
                      height: _isDesktop ? 8 : 5,
                    ),

                    Text(
                      loc.heroEyebrow.contains('\n')
                          ? loc.heroEyebrow.split('\n').last
                          : '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: _isArabic ? 'Amiri' : 'Jost',
                        fontSize: _isDesktop ? 11 : 10,
                        fontWeight: FontWeight.w400,
                        letterSpacing: _isArabic ? 0 : 0.8,
                        color: AppColors.inkSoft,
                      ),
                    ),

                    SizedBox(
                      height: _isDesktop ? 14 : 10,
                    ),

                  ],
                ),
              ),

              // ============================================================
              // SPACE BEFORE DATE
              // ============================================================
              SizedBox(
                width: _isDesktop ? 600 : 350,
                height: _isDesktop ? 650 : 500,
                child: Image.asset(
                  'assets/images/2.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),

              // ============================================================
              // DATE / TIME
              // ============================================================

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // DAY
                  Expanded(
                    child: Column(
                      children: [
                        _horizontalLine(),
                        const SizedBox(height: 8),
                        Text(
                          loc.heroWeddingDay,
                          textAlign: TextAlign.center,
                          style: _smallElegantText(fontFamily),
                        ),
                        const SizedBox(height: 8),
                        _horizontalLine(),
                      ],
                    ),
                  ),

                  _verticalLine(),

                  // DATE
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          loc.heroWeddingDayNumber,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: _isDesktop ? 38 : 30,
                            fontWeight: FontWeight.w400,
                            color: AppColors.ink,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          loc.heroWeddingMonth,
                          textAlign: TextAlign.center,
                          style: _smallElegantText(fontFamily),
                        ),
                        Text(
                          loc.heroWeddingYear,
                          textAlign: TextAlign.center,
                          style: _smallElegantText(fontFamily),
                        ),
                      ],
                    ),
                  ),

                  _verticalLine(),

                  // TIME
                  Expanded(
                    child: Column(
                      children: [
                        _horizontalLine(),
                        const SizedBox(height: 8),
                        Text(
                          loc.heroWeddingTime,
                          textAlign: TextAlign.center,
                          style: _smallElegantText(fontFamily),
                        ),
                        const SizedBox(height: 8),
                        _horizontalLine(),
                      ],
                    ),
                  ),
                ],
              ),

              // ============================================================
              // FLOWER FRAME + COUPLE
              // ============================================================

              SizedBox(
                height: _isDesktop ? 18 : 12,
              ),

              // ============================================================
              // COUPLE NAMES
              // ============================================================

              const SizedBox(height: 10),

              Text(
                loc.heroCoupleNames,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: _isDesktop ? 43 : 32,
                  fontWeight: FontWeight.w400,
                  color: AppColors.ink,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 25),

              // ============================================================
              // CHEVRON
              // ============================================================

              GestureDetector(
                onTap: onChevronTap,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 26,
                  color: AppColors.olive,
                ),
              ),

              const SizedBox(height: 18),

            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================

  Widget _horizontalLine() {
    return Container(
      height: 1,
      width: _isDesktop ? 125 : 75,
      color: AppColors.gold,
    );
  }

  Widget _verticalLine() {
    return Container(
      width: 1,
      height: _isDesktop ? 90 : 70,
      color: AppColors.gold,
      margin: const EdgeInsets.symmetric(horizontal: 10),
    );
  }

  TextStyle _smallElegantText(String fontFamily) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: _isDesktop ? 18 : 14,
      fontWeight: FontWeight.w400,
      letterSpacing: _isArabic ? 0 : 0.3,
      color: AppColors.ink,
      height: 1.1,
    );
  }
}

// ============================================================
// PULSING HEART DIVIDER (line — heart — line)
// ============================================================

class _PulsingHeartDivider extends StatefulWidget {
  const _PulsingHeartDivider({required this.isDesktop});

  final bool isDesktop;

  @override
  State<_PulsingHeartDivider> createState() => _PulsingHeartDividerState();
}

class _PulsingHeartDividerState extends State<_PulsingHeartDivider>
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

    _scale = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lineWidth = widget.isDesktop ? 35 : 25;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: lineWidth.toDouble(),
          height: 1,
          color: AppColors.gold.withOpacity(0.4),
        ),
        const SizedBox(width: 8),
        ScaleTransition(
          scale: _scale,
          child: Icon(
            Icons.favorite,
            size: widget.isDesktop ? 16 : 13,
            color: AppColors.rosee,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: lineWidth.toDouble(),
          height: 1,
          color: AppColors.gold.withOpacity(0.4),
        ),
      ],
    );
  }
}
