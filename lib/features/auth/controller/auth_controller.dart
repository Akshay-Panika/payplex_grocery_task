import 'package:get/get.dart';
import '../../../core/utils/flutter_toast.dart';
import '../../../routes/app_routes.dart';
import '../helper/auth_preferences.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {

  final AuthRepository repository = AuthRepository();

  var isLoading = false.obs;

  // REGISTER
  Future<void> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final response = await repository.registerUser({
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "terms_accepted": true
      });

      if (response['status'] == true) {
        await AuthPreferences.saveUser(response['data']);
        FlutterToast.success(response['message']);
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        FlutterToast.error(_extractError(response));
      }

    } finally {
      isLoading.value = false;
    }
  }

  // LOGIN
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    if (isLoading.value) return; // prevent spam

    try {
      isLoading.value = true;

      final response = await repository.loginUser({
        "email": email,
        "password": password,
      });

      if (response['status'] == true) {
        await AuthPreferences.saveUser(response['data']);
        FlutterToast.success("Login successful");
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        FlutterToast.error(_extractError(response));
      }

    } catch (e) {
      FlutterToast.error("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> forgotPassword({
    required String email,
    required String newPassword,
  }) async {

    try {

      isLoading.value = true;

      final response =
      await repository.forgotPassword({

        "email": email,
        "new_password": newPassword,
      });

      print(response);

      if (response['status'] == true) {

        FlutterToast.success(
          response['message'] ??
              "Password updated successfully",
        );

        Get.back();

      } else {

        FlutterToast.error(
          response['message'] ??
              _extractError(response),
        );
      }

    } catch (e) {

      print(e);

      FlutterToast.error(
        "Something went wrong",
      );

    } finally {

      isLoading.value = false;
    }
  }

  Future<void> logout() async {

    await AuthPreferences.logout();

    FlutterToast.success(
      "Logged out successfully",
    );

    Get.offAllNamed(
      AppRoutes.login,
    );
  }

  String _extractError(Map<String, dynamic> response) {
    if (response['errors'] is Map) {
      final errors = response['errors'] as Map;

      final firstKey = errors.keys.first;
      final value = errors[firstKey];

      if (value is List) {
        return value.first.toString();
      } else {
        return value.toString();
      }
    }
    return "Something went wrong";
  }
}