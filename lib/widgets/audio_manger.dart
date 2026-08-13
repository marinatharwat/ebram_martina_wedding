// ============================================================
// audio_manager.dart
// ============================================================
// ملف جاهز للاستخدام في أي مشروع Flutter Web
//
// الاستخدام:
// 1. كوبي الملف ده في مجلد lib/utils/
// 2. في main.dart استخدم AudioManager زي المثال في الأسفل
// ============================================================

import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/material.dart';

// ============================================================
// AudioManager — الكلاس الرئيسي
// ============================================================
class AudioManager {
  html.AudioElement? _player;
  final String audioSrc;
  final double volume;

  /// [audioSrc] : مسار الملف الصوتي مثلاً 'assets/assets/audio/song.mp3'
  /// [volume]   : مستوى الصوت من 0.0 إلى 1.0
  AudioManager({
    required this.audioSrc,
    this.volume = 1.0,
  });

  // ----------------------------------------------------------
  // تهيئة الـ AudioElement
  // ----------------------------------------------------------
  void init() {
    _player = html.AudioElement()
      ..src = audioSrc
      ..preload = 'auto'
      ..volume = volume;

    // إخفاء معلومات الأغنية من شريط الإشعارات
    html.window.navigator.mediaSession?.metadata = null;

    // إيقاف الصوت لما المستخدم يخرج من الصفحة
    html.document.addEventListener('visibilitychange', _onVisibilityChange);
    html.window.addEventListener('pagehide', _onPageHide);
  }

  // ----------------------------------------------------------
  // تشغيل الصوت
  // ----------------------------------------------------------
  Future<void> play() async {
    try {
      if (_player == null) init();
      await _player!.play();
    } catch (e) {
      debugPrint('AudioManager play error: $e');
    }
  }

  // ----------------------------------------------------------
  // إيقاف الصوت نهائياً وتنظيف الذاكرة
  // ----------------------------------------------------------
  void stop() {
    try {
      _player?.pause();
      _player?.currentTime = 0;
      _player?.src = '';
      _player?.load();
      _player = null;
      _clearMediaSession();
    } catch (e) {
      debugPrint('AudioManager stop error: $e');
    }
  }

  // ----------------------------------------------------------
  // إيقاف مؤقت / استكمال
  // ----------------------------------------------------------
  void pause() => _player?.pause();
  void resume() => _player?.play();

  // ----------------------------------------------------------
  // toggle — شغّل لو واقف، وقّف لو شغال
  // ----------------------------------------------------------
  Future<void> toggle() async {
    if (_player == null) {
      await play();
      return;
    }
    if (_player!.paused) {
      await play();
    } else {
      stop();
    }
  }

  // ----------------------------------------------------------
  // حالة الصوت
  // ----------------------------------------------------------
  bool get isPlaying => _player != null && !(_player!.paused);

  // ----------------------------------------------------------
  // الاستماع لأحداث التشغيل والإيقاف
  // ----------------------------------------------------------
  Stream<html.Event> get onPlay => _player?.onPlay ?? const Stream.empty();
  Stream<html.Event> get onPause => _player?.onPause ?? const Stream.empty();

  // ----------------------------------------------------------
  // تنظيف لما الـ widget يتدمر
  // ----------------------------------------------------------
  void dispose() {
    html.document.removeEventListener('visibilitychange', _onVisibilityChange);
    html.window.removeEventListener('pagehide', _onPageHide);
    stop();
  }

  // ----------------------------------------------------------
  // Private helpers
  // ----------------------------------------------------------
  void _onVisibilityChange(html.Event _) {
    if (html.document.visibilityState == 'hidden') stop();
  }

  void _onPageHide(html.Event _) {
    _player?.pause();
  }

  void _clearMediaSession() {
    js.context.callMethod('eval', ['''
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
    ''']);
  }
}

// ============================================================
// AudioProvider — InheritedWidget عشان توصله من أي مكان
// ============================================================
class AudioProvider extends InheritedWidget {
  final AudioManager audioManager;

  const AudioProvider({
    super.key,
    required this.audioManager,
    required super.child,
  });

  static AudioManager of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AudioProvider>()!
        .audioManager;
  }

  @override
  bool updateShouldNotify(AudioProvider oldWidget) => false;
}

// ============================================================
// مثال الاستخدام في main.dart
// ============================================================
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class _AppEntry extends StatefulWidget {
//   const _AppEntry();
//   @override
//   State<_AppEntry> createState() => _AppEntryState();
// }
//
// class _AppEntryState extends State<_AppEntry> {
//   html.AudioElement? _audio;
//   bool _showHome = false;
//
//   void _onOpen(html.AudioElement audio) {
//     if (_showHome) return;
//     setState(() {
//       _audio = audio;
//       _showHome = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         if (_audio != null) HomeScreen(bgAudio: _audio!),
//         if (!_showHome) CurtainScreen(onOpen: _onOpen),
//       ],
//     );
//   }
// }
//
// ============================================================
// مثال الاستخدام في HomeScreen
// ============================================================
//
// class _HomeScreenState extends State<HomeScreen> {
//   late final AudioManager _audio;
//   bool _isPlaying = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _audio = AudioManager(audioSrc: 'assets/assets/audio/song.mp3');
//     _audio.init();
//     _audio.onPlay.listen((_) => setState(() => _isPlaying = true));
//     _audio.onPause.listen((_) => setState(() => _isPlaying = false));
//   }
//
//   @override
//   void dispose() {
//     _audio.dispose();
//     super.dispose();
//   }
//
//   void _toggleAudio() async {
//     await _audio.toggle();
//     setState(() => _isPlaying = _audio.isPlaying);
//   }
// }