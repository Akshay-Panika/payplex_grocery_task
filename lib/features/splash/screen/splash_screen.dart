import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payplex_grocery_task/core/constant/app_size.dart';
import 'package:payplex_grocery_task/core/widget/app_card.dart';

import '../../../core/constant/app_color.dart';
import '../../../routes/app_routes.dart';
import '../../auth/helper/auth_preferences.dart';
import '../../auth/screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnim = Tween<double>(
      begin: 0.82,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();

    Timer(
      const Duration(seconds: 3),
          () {

        final isLoggedIn =
        AuthPreferences.isLoggedIn();

        if (isLoggedIn) {

          Get.offAllNamed(
            AppRoutes.dashboard,
          );

        } else {

          Get.offAllNamed(
            AppRoutes.login,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.primary,

      body: Stack(
        children: [

          Positioned(
            top: -80,
            right: -80,

            child: Container(
              width: 260,
              height: 260,

              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -60,
            left: -60,

            child: Container(
              width: 180,
              height: 180,

              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Center(
            child: FadeTransition(
              opacity: _fadeAnim,

              child: ScaleTransition(
                scale: _scaleAnim,

                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: [

                    AppCard(
                      width: context.sHeight*0.08,
                      height:  context.sHeight*0.08,
                      child: Center(
                        child: Text(
                          "GM",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight:
                            FontWeight.w800,
                            color: AppColor.primary,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      "GroceryMart",
                      style: GoogleFonts.poppins(
                        fontSize: context.text22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,

            child: Center(
              child: Text(
                "Powered by GroceryMart",
                style: TextStyle(
                  fontSize: 12,
                  color:
                  Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}