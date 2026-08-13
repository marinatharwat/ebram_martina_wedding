import 'package:ebram_martina_wedding/utils/localizations.dart';
import 'package:ebram_martina_wedding/widgets/count_down.dart';
import 'package:ebram_martina_wedding/widgets/date_picker_section.dart';
import 'package:ebram_martina_wedding/widgets/insta.dart';
import 'package:ebram_martina_wedding/widgets/language_toggle.dart';
import 'package:ebram_martina_wedding/widgets/rsvp_section.dart';
import 'package:ebram_martina_wedding/widgets/test.dart';
import 'package:ebram_martina_wedding/widgets/venue_section.dart';
import 'package:flutter/material.dart';
import 'open.dart';
import 'theme/app_theme.dart';
import 'widgets/hero_section.dart';

import 'package:flutter/gestures.dart';
import 'dart:html' as html;
import 'dart:js' as js;

import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WeddingInvitationApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class WeddingInvitationApp extends StatelessWidget {
  const WeddingInvitationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: "Ebram & Martina — We're Getting Married",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.crimson,
          primary: AppColors.crimson,
        ),
      ),
      home: const _RootScreen(),
    );
  }
}

class _RootScreen extends StatefulWidget {
  const _RootScreen();

  @override
  State<_RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<_RootScreen> {
  html.AudioElement? _audio;
  bool _showHome = false;

  void _onOpen(html.AudioElement audio) {
    if (_showHome) return;
    setState(() {
      _audio = audio;
      _showHome = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // دايماً موجود في الخلف عشان الـ BackdropFilter يشتغل
        WeddingInvitationPage(bgAudio: _audio),

        if (!_showHome) CurtainScreen(onOpen: _onOpen),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class WeddingInvitationPage extends StatefulWidget {
  final html.AudioElement? bgAudio;

  const WeddingInvitationPage({super.key, required this.bgAudio});

  @override
  State<WeddingInvitationPage> createState() => _WeddingInvitationPageState();
}

class _WeddingInvitationPageState extends State<WeddingInvitationPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _datePickerKey = GlobalKey();

  String _locale = 'en';

  html.AudioElement? _bgPlayer;
  bool _isPlaying = false;
  bool audioReady = true;

  @override
  void initState() {
    super.initState();

    if (widget.bgAudio != null) {
      _initAudio(widget.bgAudio!);
    }

    html.window.navigator.mediaSession?.metadata = null;
    html.document.addEventListener('visibilitychange', _onVisibilityChange);
    html.window.addEventListener('pagehide', _onPageHide);
  }

  @override
  void didUpdateWidget(WeddingInvitationPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.bgAudio != null && oldWidget.bgAudio == null) {
      _initAudio(widget.bgAudio!);
    }
  }

  void _initAudio(html.AudioElement audio) {
    _bgPlayer = audio;
    _isPlaying = !_bgPlayer!.paused;

    _bgPlayer!.onPause.listen((_) {
      if (mounted) setState(() => _isPlaying = false);
    });

    _bgPlayer!.onPlay.listen((_) {
      if (mounted) setState(() => _isPlaying = true);
    });
  }

  // =========================
  // 🎧 AUDIO CONTROLS
  // =========================

  Future<void> _playAudio() async {
    try {
      if (_bgPlayer == null) {
        _bgPlayer = html.AudioElement()
          ..src = 'assets/assets/audio/special_message.mp3'
          ..preload = 'auto'
          ..volume = 1.0;

        _bgPlayer!.onPause.listen((_) {
          if (mounted) setState(() => _isPlaying = false);
        });

        _bgPlayer!.onPlay.listen((_) {
          if (mounted) setState(() => _isPlaying = true);
        });
      }

      await _bgPlayer!.play();
      if (mounted) setState(() => _isPlaying = true);
    } catch (e) {
      debugPrint("Play error: $e");
    }
  }

  void _stopAudio() {
    try {
      final oldPlayer = _bgPlayer;
      oldPlayer?.pause();
      oldPlayer?.currentTime = 0;
      _bgPlayer = null;
      oldPlayer?.src = '';
      oldPlayer?.load();
      _clearMediaSession();
      if (mounted) setState(() => _isPlaying = false);
    } catch (e) {
      debugPrint("Stop error: $e");
    }
  }

  Future<void> _toggleAudio() async {
    if (_isPlaying) {
      _stopAudio();
    } else {
      await _playAudio();
    }
  }

  void _clearMediaSession() {
    js.context.callMethod('eval', [
      '''
      if ('mediaSession' in navigator) {
        navigator.mediaSession.metadata = null;
        navigator.mediaSession.playbackState = "none";
        try { navigator.mediaSession.setActionHandler("play", null); } catch(e){}
        try { navigator.mediaSession.setActionHandler("pause", null); } catch(e){}
        try { navigator.mediaSession.setActionHandler("stop", null); } catch(e){}
        try { navigator.mediaSession.setActionHandler("seekbackward", null); } catch(e){}
        try { navigator.mediaSession.setActionHandler("seekforward", null); } catch(e){}
        try { navigator.mediaSession.setActionHandler("previoustrack", null); } catch(e){}
        try { navigator.mediaSession.setActionHandler("nexttrack", null); } catch(e){}
      }
    ''',
    ]);
  }

  void _onVisibilityChange(html.Event _) {
    if (html.document.visibilityState == 'hidden') _stopAudio();
  }

  void _onPageHide(html.Event _) {
    _bgPlayer?.pause();
  }

  // =========================
  // UI
  // =========================

  void _toggleLocale() {
    setState(() => _locale = _locale == 'en' ? 'ar' : 'en');
  }

  void _scrollToDatePicker() {
    final ctx = _datePickerKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    html.document.removeEventListener('visibilitychange', _onVisibilityChange);
    html.window.removeEventListener('pagehide', _onPageHide);

    _bgPlayer?.pause();
    _bgPlayer?.currentTime = 0;
    _bgPlayer?.src = '';
    _bgPlayer?.load();
    _clearMediaSession();

    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations(_locale);

    return Scaffold(
      body: Directionality(
        textDirection: loc.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final deviceType = Responsive.deviceTypeOf(constraints.maxWidth);
            return Stack(
              children: [
                ListView(
                  controller: _scrollController,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    HeroSection(
                      deviceType: deviceType,
                      loc: loc,
                      onChevronTap: _scrollToDatePicker,
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: MemoriesSection(
                        title: loc.photosTitle,
                        body: loc.photosBody,
                        images: const [
                          'assets/images/10.jpeg',
                          'assets/images/3.jpeg',
                          'assets/images/1.jpeg',
                          'assets/images/4.jpeg',
                          'assets/images/6.jpeg',
                          'assets/images/5.jpeg',
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    DatePickerSection(
                      key: _datePickerKey,
                      deviceType: deviceType,
                      loc: loc,
                    ),

                    const SizedBox(height: 50),

                    WeddingCountdownGarland( loc: loc,),
                    const SizedBox(height: 50),

                    ChurchSection( loc: loc),

                    // ---------- RSVP ----------
                    RsvpSection(deviceType: deviceType, loc: loc),

                    const SizedBox(height: 100),
                    MomentoInstagramWidget(loc: loc),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Align(
                      alignment: loc.isArabic
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        height: 55,
                        color: AppColors.paper,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LanguageToggle(
                            currentLocale: _locale,
                            onToggle: _toggleLocale,
                            isPlaying: _isPlaying,
                            audioReady: audioReady,
                            onToggleAudio: _toggleAudio,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

