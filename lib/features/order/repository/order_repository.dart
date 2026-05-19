// order_repository.dart

import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoint.dart';

class OrderRepository {

  // CREATE ORDER
  Future<Response> createOrder({
    required List<int> items,
    required double totalAmount,
    required String paymentStatus,
  }) async {

    final body = {

      "items": items,

      "total_amount": totalAmount,

      "status": paymentStatus,
    };

    final response = await ApiClient.dio.post(

      ApiEndpoint.createOrder,

      data: body,
    );

    return response;
  }

  // GET ORDER LIST
  Future<Response> getOrderList() async {

    final response = await ApiClient.dio.get(
      ApiEndpoint.orderList,
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