import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoint.dart';
import '../model/category_model.dart';

class CategoryRepository {

  Future<List<CategoryModel>> getCategories() async {

    try {

      final response = await ApiClient.dio.get(
        ApiEndpoint.categoryList,
      );

      if (response.data['status'] == true) {

        final List data = response.data['data'];

        return data
            .map((e) => CategoryModel.fromJson(e))
            .toList();
      }

      return [];

    } on DioException {

      return [];
    }
  }
}