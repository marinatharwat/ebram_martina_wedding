import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ---------------------------------------------------------------------------
/// COLOR TOKENS
/// ---------------------------------------------------------------------------
class AppColors {
  AppColors._();

  /// Backgrounds
  static const Color paper = Color(0xFFFFFCF8);
  static const Color cream = Color(0xFFF7F1E8);

  /// Main wedding palette
  static const Color sage = Color(0xFFA8B59A);
  static const Color sageLight = Color(0xFFDDE3D5);
  static const Color olive = Color(0xFF737F62);

  /// Romantic accents
  static const Color blush = Color(0xFFE8B8B3);
  static const Color dustyRose = Color(0xFFC98F8A);
  static const Color terracotta = Color(0xFFB97868);

  /// Warm accent
  static const Color gold = Color(0xFFC7A66A);

  /// Text
  static const Color ink = Color(0xFF3E4638);
  static const Color inkSoft = Color(0xFF756F63);
  static const Color rosee = Color(0xFFEEA1AB);

  /// Backward compatibility
  static const Color rosePale = blush;
  static const Color rose = dustyRose;
  static const Color crimson = terracotta;
  static const Color crimsonDeep = ink;

}
/// ---------------------------------------------------------------------------
/// TYPE TOKENS
/// Italiana   -> names / monogram (display serif)
/// Marcellus  -> section titles, card-corner marks (caps serif)
/// Italianno  -> the cursive "love" accent in the footer
/// Jost       -> body copy, buttons, dates
/// ---------------------------------------------------------------------------
class AppText {
  static const String playfair = 'Playfair';

  AppText._();

  static TextStyle names(double size) => GoogleFonts.italiana(
        fontSize: size,
        color: AppColors.crimsonDeep,
        letterSpacing: size * 0.03,
        height: 1,
      );

  static TextStyle title(double size) => GoogleFonts.marcellus(
        fontSize: size,
        color: AppColors.crimsonDeep,
        letterSpacing: 1,
        height: 1.15,
      );

  static TextStyle eyebrow(double size) => GoogleFonts.marcellus(
        fontSize: size,
        color: AppColors.crimson,
        height: 1.5,
      );

  static TextStyle copy(double size) => GoogleFonts.jost(
        fontSize: size,
        color: AppColors.inkSoft,
        height: 1.7,
        fontWeight: FontWeight.w300,
      );

  static TextStyle button = GoogleFonts.jost(
    fontSize: 13,
    color: Colors.white,
    letterSpacing: 1.2,
    fontWeight: FontWeight.w500,
  );

  static TextStyle script(double size) => GoogleFonts.italianno(
        fontSize: size,
        color: AppColors.crimson,
        height: 1,
      );

  static TextStyle monogram = GoogleFonts.italiana(
    fontSize: 16,
    color: AppColors.inkSoft,
    letterSpacing: 3,
  );


  static TextStyle heroTitle = TextStyle(
  fontFamily: 'Georgia',
  fontSize: 52,
  fontWeight: FontWeight.bold,
    color: AppColors.crimson,
  height: 1.1,
  );

  static TextStyle heroSubtitle = TextStyle(
  fontFamily: 'Georgia',
  fontSize: 18,
  fontStyle: FontStyle.italic,
    color: AppColors.crimson,  letterSpacing: 1.5,
  );

  static TextStyle sectionTitle = const TextStyle(
  fontFamily: 'Georgia',
  fontSize: 20,
  fontWeight: FontWeight.bold,
    color: AppColors.crimson,
    letterSpacing: 3,
  );

  static TextStyle body = const TextStyle(
  fontSize: 14,
    color: AppColors.crimson,  height: 1.6,
  );

  static TextStyle countdown = const TextStyle(
  fontFamily: 'Georgia',
  fontSize: 36,
  fontWeight: FontWeight.bold,
    color: AppColors.crimson,  );

  static TextStyle countdownLabel = const TextStyle(
  fontSize: 12,
    color: AppColors.crimson,  letterSpacing: 2,
  );
  }


/// ---------------------------------------------------------------------------
/// RESPONSIVE BREAKPOINTS
/// mobile  < 700
/// tablet  700–1023
/// desktop >= 1024
/// ---------------------------------------------------------------------------
enum DeviceType { mobile, tablet, desktop }

class Responsive {
  Responsive._();

  static const double tabletBreakpoint = 700;
  static const double desktopBreakpoint = 1024;

  static DeviceType deviceTypeOf(double width) {
    if (width >= desktopBreakpoint) return DeviceType.desktop;
    if (width >= tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  /// Max content width inside a section — sections themselves are full-width.
  static double contentMaxWidth(DeviceType type) {
    switch (type) {
      case DeviceType.desktop:
        return 900;
      case DeviceType.tablet:
        return 640;
      case DeviceType.mobile:
        return double.infinity; // Mobile: content fills padded width
    }
  }

  /// Horizontal padding inside each section, per breakpoint.
  static double sectionPaddingX(DeviceType type) {
    switch (type) {
      case DeviceType.desktop:
        return 80;
      case DeviceType.tablet:
        return 56;
      case DeviceType.mobile:
        return 24;
    }
  }

  /// Simple fluid-type helper.
  static double clamp(double min, double preferred, double max) {
    return preferred.clamp(min, max);
  }
}
