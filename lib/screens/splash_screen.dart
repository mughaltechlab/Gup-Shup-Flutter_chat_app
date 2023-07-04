import 'package:chat_app/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AuthenticationScreen()),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.grey,
              Colors.black,
              // Colors.blue.shade900,
              // Colors.purple,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // icon
            ZoomIn(
              duration: const Duration(milliseconds: 1100),
              child: SlideInDown(
                duration: const Duration(milliseconds: 1300),
                child: Transform.rotate(
                  angle: math.pi / 10,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      // color: Colors.black,
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.grey.shade900,
                        ],
                      ),
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(15).copyWith(
                        bottomLeft: Radius.zero,
                      ),
                    ),
                    child: const Icon(
                      Icons.message,
                      size: 50,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ),
            // g u p with animation
            Transform.rotate(
              angle: math.pi / 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideInDown(
                    duration: const Duration(milliseconds: 300),
                    child: const Text(
                      'G',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'cursive',
                        fontSize: 34,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  SlideInDown(
                    duration: const Duration(milliseconds: 450),
                    child: const Text(
                      'U',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'cursive',
                        color: Colors.white70,
                        fontSize: 34,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  SlideInDown(
                    duration: const Duration(milliseconds: 550),
                    child: const Text(
                      'P',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'cursive',
                        color: Colors.white70,
                        fontSize: 34,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // s h u p with animation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideInDown(
                  duration: const Duration(milliseconds: 650),
                  child: const Text(
                    'S',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'cursive',
                      color: Colors.white70,
                      fontSize: 34,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SlideInDown(
                  duration: const Duration(milliseconds: 750),
                  child: const Text(
                    'H',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white70,
                      fontFamily: 'cursive',
                      fontSize: 34,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SlideInDown(
                  duration: const Duration(milliseconds: 850),
                  child: const Text(
                    'U',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white70,
                      fontFamily: 'cursive',
                      fontSize: 34,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SlideInDown(
                  duration: const Duration(milliseconds: 950),
                  child: const Text(
                    'P',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'cursive',
                      color: Colors.white70,
                      fontSize: 34,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
