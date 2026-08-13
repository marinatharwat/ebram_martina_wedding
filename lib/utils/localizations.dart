/// All user-facing copy for the invitation, in English and Arabic.
///
/// Usage: `final loc = AppLocalizations(locale);` then read e.g. `loc.rsvpTitle`.
/// `locale` is just `'en'` or `'ar'` — swap it in `setState` to flip the
/// whole page's language (and, paired with `Directionality`, its reading
/// direction too).
class AppLocalizations {
  final String locale;
  const AppLocalizations(this.locale);

  bool get isArabic => locale == 'ar';

  String get youAreInvited =>
      isArabic ? 'أنتم مدعوون إلى حفل زفافنا' : 'You are invited to our wedding';

  String get theWeddingOf =>
      isArabic ? 'حفل زفاف' : 'THE WEDDING OF';

  // ---------------------------------------------------------------------
  // Top bar
  // ---------------------------------------------------------------------

  String get appTagline => isArabic
      ? 'ابرام ومارتينا — حفل زفافنا'
      : "Ebram & Martina — We're Getting Married";

  // ---------------------------------------------------------------------
  // Hero
  // ---------------------------------------------------------------------

  String get heroEyebrow => isArabic
      ? 'وَيَكُونُ الاثْنَانِ جَسَدًا وَاحِدًا. إِذًا لَيْسَا بَعْدُ اثْنَيْنِ بَلْ جَسَدٌ وَاحِدٌ.\n(مرقس 10:8)'
      : 'And they twain shall be one flesh: so then they are no more twain, but one flesh.\n(Mark 10:8)';

  String get heroCoupleNames =>
      isArabic ? 'ابرام ومارتينا' : 'Ebram & Martina';

  String get heroWeddingDate =>
      isArabic ? '٩ / ١٠ / ٢٠٢٦' : '9 / 10 / 2026';

  // اليوم، اليوم بالرقم، الشهر، السنة، الوقت — كلهم منفصلين عشان الكروت
  String get heroWeddingDay =>
      isArabic ? 'الجمعة' : 'FRIDAY';

  String get heroWeddingDayNumber =>
      isArabic ? '٩' : '9';

  String get heroWeddingMonth =>
      isArabic ? 'أكتوبر' : 'OCTOBER';

  String get heroWeddingYear =>
      isArabic ? '٢٠٢٦' : '2026';

  String get heroWeddingTime =>
      isArabic ? '٨:٠٠ م' : '8:00 PM';

  // ---------------------------------------------------------------------
  // Wedding Details
  // ---------------------------------------------------------------------

  String get weddingVenue => isArabic
      ? 'الكنيسة الإنجيلية بالإسماعيلية'
      : 'The Evangelical Church in Ismailia';

  String get weddingVenueLocation => isArabic
      ? 'أمام بنك قناة السويس'
      : 'Opposite Suez Canal Bank';

  String get weddingLocation => isArabic
      ? 'الكنيسة الإنجيلية بالإسماعيلية — أمام بنك قناة السويس'
      : 'The Evangelical Church in Ismailia — Opposite Suez Canal Bank';

  String get weddingHall =>
      isArabic ? 'لا توجد قاعة' : 'No reception venue';

  // ---------------------------------------------------------------------
  // Couple initials
  // ---------------------------------------------------------------------

  String get heroLetterA => 'E';
  String get heroLetterH => 'A';

  String get photosTitle => isArabic ? 'لحظات من حكايتنا' : 'Moments From Our Story';

  String get photosBody => isArabic
      ? 'كل صورة هنا شاهدة على كل لحظة عشناها مع بعض، من أول نظرة لليوم اللي قررنا فيه نبدأ حياتنا سوا. ذكريات بسيطة، لكنها كانت بداية أجمل قصة حب.'
      : 'Every photo here holds a moment we lived together, from our very first look to the day we decided to begin our forever. Simple memories that became the beginning of the most beautiful love story.';

  String get datePickerTitle => isArabic ? 'ضيوفنا الأعزاء' : 'Dear Guests';

  String get datePickerBody => isArabic
      ? 'بكل حب وفرح، ندعوكم لمشاركتنا واحدة من أجمل لحظات حياتنا. حضوركم سيجعل هذا اليوم أكثر دفئًا وسعادة، ويسعدنا أن نبدأ هذه الرحلة الجديدة وأنتم بجانبنا.'
      : 'With love and joy, we warmly invite you to share one of the most meaningful days of our lives. Your presence will make our celebration even more special as we begin this beautiful journey together.';

  // ---------------------------------------------------------------------
  // RSVP
  // ---------------------------------------------------------------------
  String get rsvpTitle => isArabic ? 'تأكيد الحضور' : 'RSVP';
  String get rsvpBody => isArabic
      ? 'نريد أن تحملوا أجمل الذكريات عن زفافنا. لمساعدتنا في التحضير، نرجو منكم تعبئة استمارة قصيرة.'
      : 'We want you to have the warmest memories of our wedding. To help us '
      'plan, we kindly ask you to fill out a short form.';
  String get rsvpConfirm => isArabic ? 'تأكيد الحضور' : 'Confirm attendance';
  String get rsvpThankYou => isArabic ? 'شكراً لكم! ♥' : 'Thank you! ♥';




  // ---------------------------------------------------------------------
  // Venue
  // ---------------------------------------------------------------------
  String get venueTitle => isArabic ? 'القاعة' : 'Venue';
  String get venueAddress =>
      isArabic ? 'جناح الحديقة — القاهرة، مصر' : 'The Garden Pavilion — Cairo, Egypt';




  // ---------------------------------------------------------------------
  // Contact
  // ---------------------------------------------------------------------
  String get contactTitle => isArabic ? 'تواصل معنا' : 'Contact';
  String get contactBody => isArabic
      ? 'هل لديكم سؤال أو مفاجأة صغيرة لنا؟ لا تترددوا في التواصل مع منظمة حفل زفافنا، ليلى.'
      : 'Have a question, or a little surprise for us? Feel free to reach '
      'out to our wedding coordinator, Layla.';
  String get contactRole => isArabic ? 'منظمة الحفل' : 'Wedding coordinator';
  String get contactPhone => '+20 100 123 4567';

  // ---------------------------------------------------------------------
  // CTA + photo
  // ---------------------------------------------------------------------
  String get ctaTitle => isArabic
      ? 'لا يمكننا الانتظار\nللاحتفال\nمعكم!'
      : "We Can't Wait\nTo Celebrate\nWith You!";

  // ---------------------------------------------------------------------
  // Footer
  // ---------------------------------------------------------------------
  String get footerEyebrow => isArabic ? 'محظوظون بـ' : 'LUCKY IN';
  String get footerScript => isArabic ? 'الحب' : 'love';
  String get footerMonogram => isArabic ? 'أ  و  ح' : 'A & H';


  String get guestAttendingQuestion => isArabic ? 'هل ستحضر؟' : 'Will you attend?';

  String get guestAttendingYes => isArabic ? 'نعم بكل فرح' : 'Yes, with joy';

  String get guestAttendingNo => isArabic ? 'للأسف لا' : 'Sadly, no';
// ---------------------------------------------------------------------
// Countdown (Hero)
// ---------------------------------------------------------------------

  DateTime get weddingDate => DateTime(2026, 11, 21);

  bool get isWeddingDay {
    final now = DateTime.now();

    return now.year == weddingDate.year &&
        now.month == weddingDate.month &&
        now.day == weddingDate.day;
  }

  /// العنوان الرئيسي
  String get heroCountdownTitle => isWeddingDay
      ? (isArabic ? 'اليوم هو يومنا!' : "TODAY'S THE DAY")
      : (isArabic
      ? 'العد التنازلي'
      : "Counting down");

  /// العنوان الفرعي أسفل "Counting down" (كان مكتوب Hardcoded "TO OUR FOREVER")
  String get heroCountdownSubtitle =>
      isArabic ? 'إلى الأبد معًا' : 'TO OUR FOREVER';

  /// التاريخ
  String get countdownDate =>
      isArabic ? '٩ . ١٠ . ٢٠٢٦' : '09 . 10 . 2026';

  /// Units labels
  String get unitDays => isArabic ? 'أيام' : 'DAYS';
  String get unitHours => isArabic ? 'ساعات' : 'HOURS';
  String get unitMinutes => isArabic ? 'دقائق' : 'MIN';
  String get unitSeconds => isArabic ? 'ثواني' : 'SEC';

  // ---------------------------------------------------------------------
// Guest Message
// ---------------------------------------------------------------------

  String get guestMessageTitleLine1 =>
      isArabic ? 'اتركوا لنا' : 'Leave us a';

  String get guestMessageTitleLine2 =>
      isArabic ? 'رسالة' : 'message';

  String get guestMessageNameHint =>
      isArabic ? 'اسمك' : 'Your name';

  String get guestMessageHint =>
      isArabic ? 'اكتبوا لنا شيئاً جميلاً...' : 'Write something sweet...';

  String get guestMessageSendButton =>
      isArabic ? 'أرسلوا بكل حب ' : 'Send with love';

  String get guestMessageThankYouTitle =>
      isArabic ? 'شكراً لكم!' : 'Thank You!';

  String guestMessageThankYouBody(String name) => isArabic
      ? '$name، رسالتكم الجميلة أسعدت يومنا.'
      : '$name, your lovely message made our day.';

  String get guestMessageThankYouFooter => isArabic
      ? 'لا يسعنا الانتظار للاحتفال معكم ♥'
      : 'We can’t wait to celebrate with you ♥';

// ---------------------------------------------------------------------
// Venue / Location
// ---------------------------------------------------------------------



  String get venueTag =>
      isArabic ? 'حفل الزفاف' : 'Reception';

  String get venueName =>
      isArabic ? 'قاعة 7 سكاي' : '7 Sky Hall';



  String get venueOpenMap =>
      isArabic ? 'افتح في خرائط جوجل' : 'Open in Google Maps';

  // ---------------------------------------------------------------------
// Details
// ---------------------------------------------------------------------


  String get detailsDateText => isArabic
      ? 'سيُقام فرحنا يوم 28 يوليو، ويسعدنا كثيرًا أن تكونوا معنا لمشاركة هذه اللحظة المميزة.'
      : "Our wedding day is on July 28th, and we'd love for you to be there to share this special moment with us.";

  String get detailsTimeText => isArabic
      ? 'يبدأ حفل الإكليل في تمام الساعة السابعة مساءً بكنيسة العدرا والقديس أثناسيوس الرسول بمدينة نصر، فنرجو التكرم بالحضور في الموعد حتى لا تفوتكم أي لحظة من الاحتفال.'
      : "The ceremony begins at 7:00 PM at Church of the Virgin Mary & St. Athanasius the Apostolic in Madinet Nasr, so please join us on time so you don't miss a moment of the celebration.";
// ---------------------------------------------------------------------
// Venue / Location (حفل الزفاف - القاعة) — أضف العنوان الناقص هنا فقط
// ---------------------------------------------------------------------


// ---------------------------------------------------------------------
// Church (الكنيسة - الإكليل) — مجموعة جديدة كاملة
// ---------------------------------------------------------------------

  // ── قسم الفرح — أضيفيها في نفس ملف AppLocalizations ──

// ── قسم الفرح — أضيفيها في نفس ملف AppLocalizations ──
// نفس مكان الكنيسة بالظبط (كنيسة العدرا والقديس أثناسيوس الرسول - مدينة نصر)

  String get partyTitle => isArabic ? 'الفرح' : 'The Wedding';

  String get partyTag => isArabic ? 'الفرح' : 'Wedding Celebration';

  String get partyName => isArabic
      ? 'كنيسة العدرا والقديس أثناسيوس الرسول'
      : 'Saint Mary & Saint Athanasius Church';

  String get partyAddress =>
      isArabic ? 'مدينة نصر، القاهرة' : 'Nasr City, Cairo';

  String get partyDayName => isArabic ? 'الثلاثاء' : 'Tuesday';

  String get partyDate => isArabic ? '٢٨ . ٠٧ . ٢٠٢٦' : '28 . 07 . 2026';

  String get partyTime => isArabic ? 'الساعة ٧ مساءً' : '7:00 PM';

  String get partyNote => isArabic
      ? 'يرجى الحضور قبل الميعاد بربع ساعة'
      : 'Kindly arrive 15 minutes before the scheduled time';

// نفس لينك خريطة الكنيسة بالظبط
  String get partyMapUrl => 'https://maps.app.goo.gl/YxdAyRrW5HNgxXcAA?g_st=afm';

  String get partyOpenMap =>
      isArabic ? 'افتح الموقع على الخريطة' : 'Open in Maps';
  String get churchTitle =>
      isArabic ? 'مكان الكنيسة' : 'The Church';

  String get churchTag =>
      isArabic ? 'حفل الإكليل' : 'Ceremony';

  String get churchName =>
      isArabic
          ? 'كنيسة العدرا والقديس أثناسيوس الرسول'
          : 'Church of the Virgin Mary & St. Athanasius the Apostolic';

  String get churchAddress =>
      isArabic ? 'مدينة نصر، القاهرة' : 'Madinet Nasr, Cairo';

  String get churchTime =>
      isArabic ? 'الساعة 7:00 مساءً' : 'At 7:00 PM';

  String get churchOpenMap =>
      isArabic ? 'افتح في خرائط جوجل' : 'Open in Google Maps';
  String get followOurWork =>
      isArabic ? 'تابع أعمالنا' : 'FOLLOW OUR WORK';
  List<String> get weekdayShort => isArabic
      ? const [
    'أحد',
    'اثن',
    'ثلا',
    'أرب',
    'خمي',
    'جمع',
    'سبت',
  ]
      : const [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];
  String monthYearLabel(int month, int year) {
    const enMonths = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    const arMonths = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];



    final monthName =
    isArabic ? arMonths[month - 1] : enMonths[month - 1];

    return '$monthName $year';
  }

}