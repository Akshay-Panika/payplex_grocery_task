import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payplex_grocery_task/core/constant/app_size.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/utils/flutter_toast.dart';
import '../../../core/widget/app_button.dart';
import '../../../core/widget/app_text_field.dart';
import '../../../core/widget/my_appbar.dart';
import '../controller/auth_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {

  const ForgotPasswordScreen({
    super.key,
  });

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

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

      appBar: myAppBar(
        title: "Forgot Password",
        showBackButton: true,
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.symmetric(
          horizontal: 24,
        ),

        child: Column(
          children: [

            const SizedBox(height: 40),

            /// Icon
            Container(
              width: 90,
              height: 90,

              decoration: BoxDecoration(
                color: AppColor.primaryPale,
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.lock_reset_outlined,
                size: 42,
                color: AppColor.primary,
              ),
            ),

            const SizedBox(height: 24),

            /// Title
            Text(
              "Reset Password",

              style: GoogleFonts.poppins(
                fontSize: context.text20,
                fontWeight: FontWeight.w700,
                color: AppColor.title,
              ),
            ),

            const SizedBox(height: 10),

            /// Subtitle
            Text(
              "Enter your email and new password to continue.",

              textAlign: TextAlign.center,

              style: GoogleFonts.poppins(
                fontSize: context.text12,
                color: AppColor.muted,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 36),

            /// Email
            AppTextField(
              controller: emailController,

              label: "EMAIL ADDRESS",

              hint: "Enter your email",

              icon: Icons.email_outlined,

              keyboardType:
              TextInputType.emailAddress,
            ),

            const SizedBox(height: 18),

            /// Password
            AppTextField(
              controller: passwordController,

              label: "NEW PASSWORD",

              hint: "Enter new password",

              icon: Icons.lock_outline,

              obscure: obscurePassword,

              suffixIcon: IconButton(
                onPressed: () {

                  setState(() {
                    obscurePassword =
                    !obscurePassword;
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

            const SizedBox(height: 30),

            /// Button
            Obx(
                  () => AppButton(
                text: "Reset Password",

                isLoading: controller.isLoading.value,

                onPressed: () {

                  FocusScope.of(context).unfocus();

                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {

                    FlutterToast.error(
                      "All fields are required",
                    );

                    return;
                  }

                  controller.forgotPassword(
                    email: emailController.text.trim(),
                    newPassword: passwordController.text.trim(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}