import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool handClosed = false;
  bool curtainUp = false;
  bool showLogo = false;

  late AnimationController curtainController;
  late Animation<double> curtainAnimation;

  @override
  void initState() {
    super.initState();

    curtainController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    curtainAnimation =
        Tween<double>(begin: 0, end: -600).animate(CurvedAnimation(
          parent: curtainController,
          curve: Curves.easeInOut,
        ));

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        handClosed = true;
      });

      Future.delayed(Duration(milliseconds: 500), () {
        curtainController.forward().then((_) {
          setState(() {
            showLogo = true;
          });
        });
      });
    });
  }

  @override
  void dispose() {
    curtainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Stack(
        children: [
          if (showLogo)
            Center(
              child: Image.asset(
                'assets/logo.png',
                width: 200,
              ),
            ),
          AnimatedBuilder(
            animation: curtainAnimation,
            builder: (context, child) {
              return Positioned(
                top: curtainAnimation.value,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/curtain.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                ),
              );
            },
          ),


        ],
      ),
    );
  }
}