import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petit_flutter/pages/web_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const WebPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 245, 241),

      body: Center(
        child: Lottie.asset(
          'assets/animations/intro.json',
          repeat: true,
        ),
      ),
    );
  }
}