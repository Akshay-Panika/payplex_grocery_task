// history_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/widget/app_card.dart';
import '../../../routes/app_routes.dart';
import '../../order/controller/order_controller.dart';


class HistoryScreen extends StatelessWidget {

  HistoryScreen({super.key});

  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColor.surface,

      body: Column(

        children: [

          Container(

            width: double.infinity,

            color: AppColor.white,

            padding: EdgeInsets.only(

              top:
              MediaQuery.of(context)
                  .padding
                  .top + 14,

              left: 18,
              right: 18,
              bottom: 16,
            ),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  "Order History 🧾",

                  style:
                  GoogleFonts.poppins(
                    fontSize:
                    context.text20,

                    fontWeight:
                    FontWeight.w700,

                    color:
                    AppColor.title,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "All your past orders in one place",

                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.muted,
                  ),
                ),
              ],
            ),
          ),

          Expanded(

            child: Obx(() {

              // LOADING
              if (orderController
                  .isOrderListLoading
                  .value) {

                return const Center(
                  child:
                  CircularProgressIndicator(),
                );
              }

              final orders =
                  orderController
                      .orderListModel
                      ?.data ?? [];

              // EMPTY
              if (orders.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        /// ICON
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: AppColor.primaryPale,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.receipt_long_outlined,
                            size: 40,
                            color: AppColor.primary,
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// TITLE
                        Text(
                          "No Orders Yet",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColor.title,
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// SUBTITLE
                        Text(
                          "You haven't placed any orders yet.\nStart shopping and your orders will appear here.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppColor.muted,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// BUTTON (optional)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Get.offAllNamed(AppRoutes.dashboard);

                          },
                          child: Text(
                            "Start Shopping",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return RefreshIndicator(

                onRefresh: () async {
                  await orderController.getOrderList();
                },

                child: ListView.builder(

                  padding:
                  const EdgeInsets.fromLTRB(
                      14,
                      14,
                      14,
                      20),

                  itemCount: orders.length,

                  itemBuilder:
                      (context, index) {

                    final order =
                    orders[index];

                    return AppCard(
                      margin: const EdgeInsets.only(bottom: 12),
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.showOrder,
                          arguments: order.id,
                        );
                        },
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// TOP ROW (Order ID + Delete)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text(
                                 "#${order.orderId}",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.title,
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  orderController.deleteOrder(order.id!);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          /// ITEMS
                          Text(
                            "Items : ${order.items?.length}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppColor.muted,
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// BOTTOM ROW
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              /// STATUS CHIP
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.primaryPale,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  order.paymentStatus ?? "Paid",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),

                              /// PRICE
                              Text(
                                "₹${double.tryParse(order.totalAmount ?? "0")?.toStringAsFixed(0) ?? "0"}",
                                style: GoogleFonts.poppins(
                                  fontSize: context.text14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.title,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );

                    },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}