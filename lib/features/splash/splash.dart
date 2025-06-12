import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/utils/resources/color_manager.dart';
import '../../core/utils/resources/image_manager.dart';
import '../onboarding/presentation/onboarding.dart';
import '../product/presentaion/home/view/home_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      final user = FirebaseAuth.instance.currentUser;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              user != null ? const HomeScreen() : const Onboarding(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.PrimaryColor,
      body: Center(
        child: Image.asset(ImageManager.logo),
      ),
    );
  }
}
