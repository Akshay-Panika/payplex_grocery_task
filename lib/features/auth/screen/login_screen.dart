import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payplex_grocery_task/core/constant/app_size.dart';
import 'package:payplex_grocery_task/core/widget/app_card.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/widget/app_button.dart';
import '../../../core/widget/app_text_field.dart';
import '../../../routes/app_routes.dart';
import '../controller/auth_controller.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';
import '../../../core/utils/flutter_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.find<AuthController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: context.sHeight*0.04),
        
                // Eyebrow
                AppCard(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  color: AppColor.primaryPale,
                  margin: EdgeInsets.zero,
                  child:  Text(
                    "WELCOME BACK",
                    style: GoogleFonts.poppins(
                      fontSize: context.text12,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primary,
                    ),
                  ),
                ),
        
                const SizedBox(height: 14),
        
                 Text(
                  "Sign in to\nGroceryMart 🛒",
                  style: GoogleFonts.poppins(
                    fontSize: context.text26,
                    fontWeight: FontWeight.w700,
                    color: AppColor.title,
                    height: 1.15,
                    // letterSpacing: -0.8,
                  ),
                ),
        
                const SizedBox(height: 8),
        
                Text(
                  "Your groceries, delivered fresh.",
                  style: TextStyle(
                    fontSize: context.text14,
                    color: AppColor.muted,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        
                const SizedBox(height: 36),
        
        
                AppTextField(
                  controller: emailController,
                  hint: "you@example.com",
                  icon: Icons.email_outlined,
                  label: 'EMAIL ADDRESS',
                ),
        
                const SizedBox(height: 16),

                AppTextField(
                  controller: passwordController,
                  label: "PASSWORD",
                  hint: "Enter password",
                  icon: Icons.lock_outline,
                  obscure: obscurePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColor.muted,
                    ),
                  ),
                ),
        
                const SizedBox(height: 10),
        
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.forgotPassword,),
                    child:  Text(
                      "Forgot password?",
                      style: TextStyle(
                        fontSize: context.text12,
                        fontWeight: FontWeight.w700,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                ),
        
                const SizedBox(height: 22),
        
                Obx(() => AppButton(
                  text: "Sign In",
                  isLoading: controller.isLoading.value,
                  onPressed: () {
        
                    if (controller.isLoading.value) return;
        
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      FlutterToast.error("All fields are required");
                      return;
                    }
        
                    controller.loginUser(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    FocusScope.of(context).unfocus();
                  },
                )),
        
                const SizedBox(height: 20),
        
                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColor.primaryPale, thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        "or continue with",
                        style: TextStyle(
                          fontSize: context.text12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColor.primaryPale, thickness: 1)),
                  ],
                ),
        
                const SizedBox(height: 18),
        
                // Social buttons
                Row(
                  children: [
                    Expanded(child: _socialButton(context,"🇬  Google")),
                    const SizedBox(width: 12),
                    Expanded(child: _socialButton(context,"📱  Phone")),
                  ],
                ),
        
                const SizedBox(height: 28),
        
                // Register link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New here? ",
                        style: TextStyle(color: AppColor.muted,  fontSize: context.text12,),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.register),
                        child:  Text(
                          "Create account",
                          style: TextStyle(
                            fontSize: context.text12,
                            fontWeight: FontWeight.w700,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(BuildContext context, String label) {
    return AppCard(
      height: 50,
      hasBorder: true,
      margin: EdgeInsets.zero,
      child: Center(
        child: Text(
          label,
          style:  GoogleFonts.poppins(
            fontSize: context.text14,
            fontWeight: FontWeight.w600,
            color: AppColor.title,
          ),
        ),
      ),
    );
  }
}