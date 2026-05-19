import 'package:get/get.dart';

import '../features/Order/screen/order_details_screen.dart';
import '../features/Payment/screen/payment_screen.dart';
import '../features/auth/binding/auth_binding.dart';
import '../features/auth/screen/forgot_password_screen.dart';
import '../features/auth/screen/login_screen.dart';
import '../features/auth/screen/register_screen.dart';
import '../features/dashboard/screen/dashboard_screen.dart';
import '../features/home/binding/category_binding.dart';
import '../features/home/binding/product_binding.dart';
import '../features/splash/screen/splash_screen.dart';
import 'app_routes.dart';

class AppPages {

  static const initial = AppRoutes.splash;

  static final routes = [

    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      bindings: [
        CategoryBinding(),
        ProductBinding(),
      ],
    ),

    GetPage(
      name: AppRoutes.orderDetails,
      page: () => const OrderDetailsScreen(),
    ),

    GetPage(
      name: AppRoutes.payment,
      page: () => PaymentScreen(
        totalAmount: Get.arguments['totalAmount'],
      ),
    ),
  ];
}