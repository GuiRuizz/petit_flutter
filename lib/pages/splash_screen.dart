import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petit_flutter/pages/permission_page.dart';
import 'package:petit_flutter/pages/web_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _checkPermissions() async {
    final result = await [
      Permission.camera,
      Permission.photos,
      Permission.videos,
      Permission.notification,
      Permission.microphone,
    ].request();

    final allGranted = result.values.every((status) => status.isGranted);

    if (!mounted) return;

    if (allGranted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WebPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PermissionPage()),
      );
    }
  }

  void _onAnimationFinish() {
    _checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 245, 241),

      body: Center(
        child: Lottie.asset(
          'assets/animations/intro.json',
          repeat: false,

          onLoaded: (composition) {
            Future.delayed(composition.duration, _onAnimationFinish);
          },
        ),
      ),
    );
  }
}
