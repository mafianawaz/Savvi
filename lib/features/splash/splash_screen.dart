import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../core/routing/app_router.dart';
import '../auth/auth_controller.dart';


/// Launch splash: plays the Savur logo animation once, then routes to Home
/// (restored session) or Sign-in.
///
/// The animation's own background is pure white, so the scaffold uses the
/// same colour and the video blends in with no visible frame edge.
///
/// Safety nets so the splash can never trap the member:
///  * if the video fails to load, continue after a short pause;
///  * a hard timeout continues even if playback stalls.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const videoAsset = 'assets/animations/savur_logo_splash.mp4';
  // The video's frame is pure white (255,255,255). A slightly different
  // scaffold colour shows up as a visible band around the video.
  static const background = Colors.white;

  /// Fraction of the video kept (centred) on each axis; see build().
  static const _cropW = 0.97;
  static const _cropH = 0.94;

  /// The source video is 16:9 landscape with the logo centred. On a portrait
  /// phone it is width-fitted, which leaves the wordmark small; this scales
  /// it up around the centre (safe: the frame edges are plain background).
  static const _logoScale = 1.3;

  /// Longer than the clip (~5s) so a slow device still finishes naturally.
  static const _hardTimeout = Duration(seconds: 90);
  static const _errorPause = Duration(milliseconds: 800);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController? _video;
  Timer? _timeout;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _timeout = Timer(SplashScreen._hardTimeout, _goNext);
    _start();
  }

  Future<void> _start() async {
    final controller = VideoPlayerController.asset(
      SplashScreen.videoAsset,
      // Don't interrupt music/podcasts the member already has playing.
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _video = controller;

    try {
      await controller.initialize();
      if (!mounted) return;
      await controller.setVolume(0);
      await controller.setLooping(false);
      controller.addListener(_onTick);
      setState(() {});
      await controller.play();
    } catch (e) {
      debugPrint('[SPLASH] video failed: $e');
      await Future<void>.delayed(SplashScreen._errorPause);
      _goNext();
    }
  }

  void _onTick() {
    final v = _video?.value;
    if (v == null || !v.isInitialized) return;
    if (v.hasError) {
      _goNext();
      return;
    }
    final done = v.duration > Duration.zero &&
        v.position >= v.duration - const Duration(seconds: 5);
    if (done && !v.isPlaying) _goNext();
    // Some devices never flip isPlaying off at the end; position alone is
    // enough once we are within the last frame.
    if (v.position >= v.duration) _goNext();
  }

  void _goNext() {
    if (_navigated || !mounted) return;
    _navigated = true;
    _timeout?.cancel();

    // Session was already restored synchronously in AuthController.onInit.
    final signedIn = Get.find<AuthController>().isSignedIn;
    Get.offAllNamed(signedIn ? Routes.home : Routes.signIn);
  }

  @override
  void dispose() {
    _timeout?.cancel();
    _video?.removeListener(_onTick);
    _video?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final video = _video;
    final ready = video != null && video.value.isInitialized;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: SplashScreen.background,
      ),
      child: Scaffold(
        backgroundColor: SplashScreen.background,
        body: SizedBox.expand(
          child: ready
              ? Transform.scale(
            scale: SplashScreen._logoScale,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              // Crop a thin margin off every edge of the video. The
              // frame border is plain background, but the GPU texture
              // edge can render as a thin coloured line when the
              // video is scaled; clipping inside the texture removes
              // it.
              child: ClipRect(
                child: Align(
                  alignment: Alignment.center,
                  widthFactor: SplashScreen._cropW,
                  heightFactor: SplashScreen._cropH,
                  child: SizedBox(
                    width: video.value.size.width,
                    height: video.value.size.height,
                    child: VideoPlayer(video),
                  ),
                ),
              ),
            ),
          )
          // Same colour as the video background, so nothing flashes
          // while the first frame decodes.
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}