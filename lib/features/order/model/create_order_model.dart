class CreateOrderModel {
  bool? status;
  String? message;
  String? orderId;
  OrderData? data;

  CreateOrderModel({
    this.status,
    this.message,
    this.orderId,
    this.data,
  });

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderId = json['order_id'];

    data = json['data'] != null
        ? OrderData.fromJson(json['data'])
        : null;
  }
}

class OrderData {
  int? id;
  String? orderId;
  List<dynamic>? items;
  String? totalAmount;
  String? paymentStatus;
  String? createdAt;

  OrderData({
    this.id,
    this.orderId,
    this.items,
    this.totalAmount,
    this.paymentStatus,
    this.createdAt,
  });

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    items = json['items'];
    totalAmount = json['total_amount'];
    paymentStatus = json['status'];
    createdAt = json['created_at'];
  }
}