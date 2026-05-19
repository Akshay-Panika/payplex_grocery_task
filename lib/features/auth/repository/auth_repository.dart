import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoint.dart';

class AuthRepository {

  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> data) async {
    try {
      final response = await ApiClient.dio.post(
        ApiEndpoint.register,
        data: data,
      );

      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> data) async {
    try {
      final response = await ApiClient.dio.post(
        ApiEndpoint.login,
        data: data,
      );

      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// FORGOT PASSWORD
  Future<Map<String, dynamic>> forgotPassword(
      Map<String, dynamic> data) async {

    try {

      final response = await ApiClient.dio.post(
        ApiEndpoint.forgotPassword,
        data: data,
      );

      return response.data;

    } on DioException catch (e) {

      return _handleError(e);
    }
  }

  Map<String, dynamic> _handleError(DioException e) {
    if (e.response != null) {
      return e.response!.data;
    } else {
      return {
        "status": false,
        "errors": {"message": "No internet connection"}
      };
    }
  }
}