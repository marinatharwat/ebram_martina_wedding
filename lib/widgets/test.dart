import 'package:ebram_martina_wedding/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// =======================================================================
/// MEMORIES SECTION
/// Gallery ناعمة متناسقة مع تصميم الورد والدعوة
/// =======================================================================

class MemoriesSection extends StatelessWidget {
  const MemoriesSection({
    super.key,
    required this.title,
    required this.body,
    required this.images,
    this.onImageTap,
    this.backgroundColor = const Color(0xFFF8F5EE),
  });

  final String title;
  final String body;
  final List<String> images;
  final void Function(int index)? onImageTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 55,
        horizontal: 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [


          Text(
            title,
            textAlign: TextAlign.center,
            style:  TextStyle(
              fontFamily: 'CormorantGaramond',
              fontSize: 32,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: AppColors.terracotta,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 14),

          // ===============================================================
          // DESCRIPTION
          // ===============================================================

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 430,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                body,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 13,
                  height: 1.8,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF5D5A52),
                ),
              ),
            ),
          ),

          const SizedBox(height: 38),

          // ===============================================================
          // PHOTO GALLERY
          // ===============================================================

          _MemoriesGallery(
            images: images,
            onImageTap: onImageTap,
          ),

        ],
      ),
    );
  }


}


/// =======================================================================
/// MEMORIES GALLERY
/// يظهر جزء من الصورة التالية لتوضيح وجود Scroll
/// =======================================================================

class _MemoriesGallery extends StatelessWidget {
  const _MemoriesGallery({
    required this.images,
    this.onImageTap,
  });

  final List<String> images;
  final void Function(int index)? onImageTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600;

    // ---------------------------------------------------------------
    // حجم الكارت
    //
    // الكارت لا يأخذ عرض الشاشة بالكامل.
    // بالتالي جزء من الصورة التالية يظل ظاهرًا.
    // ---------------------------------------------------------------

    final cardWidth = isMobile
        ? screenWidth * 0.72
        : 270.0;

    final galleryHeight = isMobile
        ? 390.0
        : 410.0;

    return SizedBox(
      height: galleryHeight,

      child: ListView.separated(
        scrollDirection: Axis.horizontal,

        // -------------------------------------------------------------
        // Padding
        //
        // اليمين أكبر قليلًا حتى يفضل جزء من الكارت التالي
        // واضح أثناء التمرير.
        // -------------------------------------------------------------

        padding: EdgeInsets.only(
          left: isMobile ? 24 : 35,
          right: isMobile ? 55 : 70,
        ),

        physics: const BouncingScrollPhysics(),

        itemCount: images.length,

        separatorBuilder: (_, __) {
          return const SizedBox(
            width: 14,
          );
        },

        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: onImageTap == null
                ? null
                : () => onImageTap!(index),

            child: Padding(
              // ---------------------------------------------------------
              // اختلاف بسيط في ارتفاع الصور
              // يعطي شكل Gallery طبيعي بدل صف جامد.
              // ---------------------------------------------------------

              padding: EdgeInsets.only(
                top: index.isEven ? 0 : 24,
                bottom: index.isEven ? 24 : 0,
              ),

              child: SizedBox(
                width: cardWidth,

                child: _MemoryCard(
                  image: images[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


/// =======================================================================
/// SINGLE PHOTO CARD
/// كارت الصورة بإطار Ivory وظل خفيف
/// =======================================================================

class _MemoryCard extends StatelessWidget {
  const _MemoryCard({
    required this.image,
  });

  final String image;

  bool get _isNetwork {
    return image.startsWith('http://') ||
        image.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(7),

      decoration: BoxDecoration(
        // ---------------------------------------------------------------
        // لون الورق / الإطار
        // ---------------------------------------------------------------

        color: const Color(0xFFFFFEFA),

        // ---------------------------------------------------------------
        // Border بسيط جدًا
        // ---------------------------------------------------------------

        border: Border.all(
          color: const Color(0xFFD9D5C8),
          width: 1,
        ),

        // ---------------------------------------------------------------
        // Shadow ناعم
        // ---------------------------------------------------------------

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            spreadRadius: 0,
            offset: const Offset(
              0,
              8,
            ),
          ),
        ],
      ),

      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1),

              child: _isNetwork
                  ? Image.network(
                image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
        ],
      ),
    );
  }
}