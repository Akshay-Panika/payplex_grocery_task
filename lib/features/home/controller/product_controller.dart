import 'package:get/get.dart';

import '../model/product_model.dart';
import '../repository/product_repository.dart';

class ProductController
    extends GetxController {

  final ProductRepository repository =
  ProductRepository();

  var isLoading = false.obs;

  RxList<ProductModel> productList =
      <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async {

    try {

      isLoading.value = true;

      final data =
      await repository.getProducts();

      productList.assignAll(data);

    } finally {

      isLoading.value = false;
    }
  }
}