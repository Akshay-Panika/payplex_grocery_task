import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoint.dart';
import '../model/product_model.dart';

class ProductRepository {

  Future<List<ProductModel>> getProducts() async {

    try {

      final response =
      await ApiClient.dio.get(
        ApiEndpoint.productList,
      );

      if (response.data['status'] == true) {

        final List data =
        response.data['data'];

        return data
            .map(
              (e) => ProductModel.fromJson(e),
        )
            .toList();
      }

      return [];

    } on DioException {

      return [];
    }
  }
}