// order_repository.dart

import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoint.dart';
import '../../auth/helper/auth_preferences.dart';

class OrderRepository {

  // CREATE ORDER
  Future<Response> createOrder({
    required List<int> items,
    required String totalAmount,
    required String paymentStatus,
  }) async {


    final userId = AuthPreferences.getUserId();
    if (userId == null) {
      throw Exception("User not logged in");
    }

    final body = {
      "items": items,
      "total_amount": totalAmount,
      "status": paymentStatus,
    };

    final response = await ApiClient.dio.post(
      ApiEndpoint.createOrder(userId),
      data: body,
    );

    return response;
  }

  // GET ORDER LIST
  Future<Response> getOrderList() async {

    final userId = AuthPreferences.getUserId();
    if (userId == null) {
      throw Exception("User not logged in");
    }

    final response = await ApiClient.dio.get(
      ApiEndpoint.orderList(userId),
    );

    return response;
  }

  Future<Response> deleteOrder(int orderId) async {
    final response = await ApiClient.dio.delete(
      "${ApiEndpoint.orderDelete}$orderId/",
    );

    return response;
  }
}