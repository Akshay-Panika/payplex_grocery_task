// order_controller.dart
import 'package:get/get.dart';
import 'package:payplex_grocery_task/core/utils/flutter_toast.dart';
import '../model/create_order_model.dart';
import '../model/order_list_model.dart';
import '../repository/order_repository.dart';
import 'cart_controller.dart';

class OrderController extends GetxController {

  final OrderRepository orderRepository = OrderRepository();
  final CartController cartController = Get.find<CartController>();

  RxBool isCreateOrderLoading = false.obs;
  RxBool isOrderListLoading = false.obs;
  RxBool isDeleteLoading = false.obs;


  CreateOrderModel? createOrderModel;
  OrderListModel? orderListModel;

  // CREATE ORDER
  Future<void> createOrder({

    required List<int> items,

    required double totalAmount,

    required String paymentStatus,

  }) async {

    try {

      isCreateOrderLoading.value = true;

      final response =
      await orderRepository.createOrder(

        items: items,

        totalAmount: totalAmount,

        paymentStatus: paymentStatus,
      );


      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        createOrderModel =
            CreateOrderModel.fromJson(
              response.data,
            );

        cartController.selectedProductIds.clear();
        // FlutterToast.success("Success");
        getOrderList();

      }

    } catch (e) {

      FlutterToast.error(e.toString());

    } finally {

      isCreateOrderLoading.value = false;
    }
  }

  // GET ORDER LIST
  Future<void> getOrderList() async {

    try {

      isOrderListLoading.value = true;

      final response =
      await orderRepository.getOrderList();

      if (response.statusCode == 200) {

        orderListModel = OrderListModel.fromJson(
              response.data,
            );
      }

    } catch (e) {

      FlutterToast.error(e.toString());

    } finally {

      isOrderListLoading.value = false;
    }
  }

  Future<void> deleteOrder(int orderId) async {

    try {
      isDeleteLoading.value = true;

      final response = await orderRepository.deleteOrder(orderId);

      if (response.statusCode == 200) {

        // FlutterToast.success("Order Deleted");

        getOrderList();
      }

    } catch (e) {
      FlutterToast.error(e.toString());
    } finally {
      isDeleteLoading.value = false;
    }
  }

  @override
  void onInit() {
    getOrderList();
    super.onInit();
  }
}