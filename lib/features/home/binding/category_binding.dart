import 'package:get/get.dart';

import '../../order/controller/cart_controller.dart';
import '../controller/category_controller.dart';

class CategoryBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<CategoryController>(() => CategoryController(),);
    Get.lazyPut<CartController>(() => CartController(),);
  }
}