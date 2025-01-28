import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/signIn_screen.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';
import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  Future<void> moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, SigninScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background(child: Center(child: AppLogo())),
    );
  }
}