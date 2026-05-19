import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payplex_grocery_task/routes/app_pages.dart';
import 'core/constant/app_color.dart';
import 'features/auth/binding/auth_binding.dart';
import 'features/auth/helper/auth_preferences.dart';
import 'features/splash/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FreshMart',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColor.surface,
        primaryColor: AppColor.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primary,
          primary: AppColor.primary,
          surface: AppColor.surface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.white,
          surfaceTintColor: AppColor.white,
          elevation: 0,
          centerTitle: true,
          foregroundColor: AppColor.title,
          titleTextStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColor.title,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColor.surface,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide:
            const BorderSide(color: AppColor.primaryPale, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide:
            const BorderSide(color: AppColor.primaryPale, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide:
            const BorderSide(color: AppColor.primaryLight, width: 1.5),
          ),
        ),
      ),
      initialBinding: AuthBinding(),
      getPages: AppPages.routes,
      home: const SplashScreen(),
    );
  }
}