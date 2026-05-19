import 'package:get/get.dart';

class CartController extends GetxController {

  /// selected product ids
  RxList<int> selectedProductIds = <int>[].obs;

  /// add/remove
  void toggleProduct(int productId) {

    if (selectedProductIds.contains(productId)) {
      selectedProductIds.remove(productId);
    } else {
      selectedProductIds.add(productId);
    }

    print("Selected IDs => $selectedProductIds");
  }

  /// check selected
  bool isAdded(int productId) {
    return selectedProductIds.contains(productId);
  }

  /// total cart count
  int get cartCount => selectedProductIds.length;
}