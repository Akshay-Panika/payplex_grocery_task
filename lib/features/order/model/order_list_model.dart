class OrderListModel {
  bool? status;
  int? count;
  List<OrderData>? data;

  OrderListModel({
    this.status,
    this.count,
    this.data,
  });

  OrderListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];

    if (json['data'] != null) {
      data = <OrderData>[];

      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
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