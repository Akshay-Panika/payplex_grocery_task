import 'package:get/get.dart';

import '../model/category_model.dart';
import '../repository/category_repository.dart';

class CategoryController extends GetxController {

  final CategoryRepository repository = CategoryRepository();

  var isLoading = false.obs;

  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future<void> getCategories() async {

    try {

      isLoading.value = true;

      final data =
      await repository.getCategories();

      categoryList.assignAll(data);

    } finally {

      isLoading.value = false;
    }
  }
}