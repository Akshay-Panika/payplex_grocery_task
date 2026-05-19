import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payplex_grocery_task/core/constant/app_size.dart';
import 'package:payplex_grocery_task/core/utils/flutter_toast.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/widget/app_button.dart';
import '../../../core/widget/app_text_field.dart';
import '../../../core/widget/my_appbar.dart';
import '../../../routes/app_routes.dart';
import '../controller/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final controller = Get.find<AuthController>();

  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final phoneController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final confirmPasswordController =
  TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.white,

      appBar: myAppBar(
        title: 'Create Account',
        showBackButton: true,
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.symmetric(
          horizontal: 24,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 16),

            /// Title
            Text(
              "Join GroceryMart 🌿",

              style: GoogleFonts.poppins(
                fontSize: context.text20,
                fontWeight: FontWeight.w700,
                color: AppColor.title,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Fresh groceries, just a tap away.",

              style: GoogleFonts.poppins(
                fontSize: context.text12,
                color: AppColor.muted,
              ),
            ),

            const SizedBox(height: 30),

            /// Name
            AppTextField(
              controller: nameController,

              label: "FULL NAME",

              hint: "Enter your name",

              icon: Icons.person_outline,

              keyboardType:
              TextInputType.text,
            ),

            const SizedBox(height: 16),

            /// Email
            AppTextField(
              controller: emailController,

              label: "EMAIL ADDRESS",

              hint: "Enter your email",

              icon: Icons.email_outlined,

              keyboardType:
              TextInputType.emailAddress,
            ),

            const SizedBox(height: 16),

            /// Phone
            AppTextField(
              controller: phoneController,

              label: "PHONE NUMBER",

              hint: "Enter your phone",

              icon: Icons.phone_outlined,

              keyboardType:
              TextInputType.phone,
            ),

            const SizedBox(height: 16),

            /// Password
            AppTextField(
              controller: passwordController,

              label: "PASSWORD",

              hint: "Create a password",

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

            const SizedBox(height: 16),

            /// Confirm Password
            AppTextField(
              controller:
              confirmPasswordController,

              label: "CONFIRM PASSWORD",

              hint: "Re-enter password",

              icon: Icons.lock_outline,

              obscure:
              obscureConfirmPassword,

              suffixIcon: IconButton(
                onPressed: () {

                  setState(() {
                    obscureConfirmPassword =
                    !obscureConfirmPassword;
                  });
                },

                icon: Icon(
                  obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,

                  color: AppColor.muted,
                ),
              ),
            ),

            const SizedBox(height: 32),


            Obx(() => AppButton(
              text: "Create Account",
              isLoading: controller.isLoading.value,
              onPressed: () {

                if (controller.isLoading.value) return;

                if (nameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  FlutterToast.error("All fields are required");
                  return;
                }

                if (passwordController.text != confirmPasswordController.text) {
                  FlutterToast.error("Passwords do not match");
                  return;
                }

                controller.registerUser(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  phone: phoneController.text.trim(),
                  password: passwordController.text.trim(),
                );
              },
            )),

            const SizedBox(height: 18),

            /// Login Text
            Center(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Text(
                    "Already have an account? ",

                    style:
                    GoogleFonts.poppins(
                      color:
                      AppColor.muted,
                      fontSize:
                      context.text12,
                    ),
                  ),

                  GestureDetector(
                    onTap: () => Get.offAllNamed(AppRoutes.login),
                    child: Text(
                      "Sign In",

                      style:
                      GoogleFonts.poppins(
                        fontSize:
                        context.text12,
                        fontWeight:
                        FontWeight.w700,
                        color:
                        AppColor.primary,
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
    );
  }
}