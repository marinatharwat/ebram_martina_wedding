import 'package:ebram_martina_wedding/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ebram_martina_wedding/utils/localizations.dart';

class ChurchSection extends StatelessWidget {
  const ChurchSection({
    super.key,
    required this.loc,
  });

  final AppLocalizations loc;

  Future<void> _openLocation() async {
    final Uri uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query='
          'الكنيسة+الانجيلية+بالاسماعيلية+امام+بنك+قناة+السويس',
    );

    if (kIsWeb) {
      await launchUrl(
        uri,
        webOnlyWindowName: '_blank',
      );
      return;
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = loc.isArabic;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      color: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 390,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isArabic ? 'مكان الكنيسة' : 'Church Location',
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: AppColors.terracotta,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 30,),
              // =====================================================
              // CARD
              // =====================================================
              Container(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCF9F4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFDCC79D),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.035),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const SizedBox(height: 4),

                    Text(
                      loc.weddingVenue,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 26,
                        height: 1.05,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF665F52),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: 260,
                      height: 170,
                      child: Image.asset(
                        'assets/images/curch.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // =================================================
                    // LOCATION  |  TIME  — جنب بعض دلوقتي بدل تحت بعض
                    // =================================================
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  isArabic ? 'المكان' : 'Location',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 13,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFB7A87F),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  loc.weddingVenueLocation,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 16,
                                    height: 1.15,
                                    fontStyle: FontStyle.italic,
                                    color: const Color(0xFF8A8A78),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // فاصل رأسي بيقسم الاتنين
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Container(
                              width: 1,
                              color: const Color(0xFFDCC79D),
                            ),
                          ),

                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  isArabic ? 'الميعاد' : 'Time',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 13,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFB7A87F),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isArabic ? '٨:٠٠ مساءً' : '8:00 PM',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 18,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFC5A15A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // LOCATION BUTTON
                    // =================================================
                    InkWell(
                      onTap: _openLocation,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 21,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFCDBB93),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 17,
                              color: Color(0xFF8A9276),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isArabic ? 'افتح الموقع' : 'Open Location',
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF6F765F),
                              ),
                            ),
                          ],
                        ),
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