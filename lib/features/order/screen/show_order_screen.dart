import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:payplex_grocery_task/core/widget/my_appbar.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/widget/app_card.dart';

import '../../home/controller/product_controller.dart';
import '../../order/controller/order_controller.dart';

class ShowOrderScreen extends StatefulWidget {
  final int orderId;

  const ShowOrderScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<ShowOrderScreen> createState() => _ShowOrderScreenState();
}

class _ShowOrderScreenState extends State<ShowOrderScreen> {

  final productController = Get.find<ProductController>();
  final orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.surface,

      appBar: myAppBar(
        title: "",
        showBackButton: true,
      ),

      body: Obx(() {

        /// loading
        if (orderController.isOrderListLoading.value ||
            productController.isLoading.value) {

          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        /// find current order
        final currentOrder =
        orderController.orderListModel?.data?.firstWhereOrNull(
              (order) => order.id == widget.orderId,
        );

        /// order not found
        if (currentOrder == null) {
          return const Center(
            child: Text(
              "Order Not Found",
            ),
          );
        }

        /// item ids
        final List<int> orderItemIds =
            currentOrder.items?.map((e) => e as int).toList() ?? [];

        /// filter products
        final filteredProducts = productController.productList
            .where((product) => orderItemIds.contains(product.id))
            .toList();

        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
              
                  /// HEADER
                  SliverToBoxAdapter(
                    child: Container(
                      color: AppColor.white,
                      padding: const EdgeInsets.only(
                        left: 18,
                        right: 18,
                        top: 0,
                        bottom: 16,
                      ),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
              
                          Text(
                            "Show Orders 📦",
                            style: TextStyle(
                              fontSize: context.text22,
                              fontWeight: FontWeight.w800,
                              color: AppColor.title,
                              letterSpacing: -0.6,
                            ),
                          ),
              
                          SizedBox(height: 4),
              
                          Text(
                            "Stay updated on your deliveries",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              
                  /// ACTIVE CARD
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: _activeOrderCard(),
                    ),
                  ),
              
                  /// SUMMARY TITLE
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(18, 4, 18, 10),
                      child: Text(
                        "Order Summary",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColor.title,
                        ),
                      ),
                    ),
                  ),
              
                  /// PRODUCT LIST
                  filteredProducts.isEmpty
              
                      ? const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(
                        child: Text(
                          "No Products Found",
                        ),
                      ),
                    ),
                  )
              
                      : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
              
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
              
                            (context, index) {
              
                          final product = filteredProducts[index];
              
                          return orderItem(
                            context,
              
                            productId: product.id,
              
                            image: product.productImage,
              
                            name: product.productName,
              
                            des: product.productDescription,
              
                            productPrice: product.productPrice,
              
                            discountedPrice: product.discountedPrice,
              
                            isOffer: product.isOffer,
                          );
                        },
              
                        childCount: filteredProducts.length,
                      ),
                    ),
                  ),
              
                ],
              ),
            ),
            AppCard(
              hasBorder: true,
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(left: 10,right: 10,bottom: 30,top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      Text(
                        "Payment Method",
                        style: GoogleFonts.poppins(
                          fontSize: context.text14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.muted,
                        ),
                      ),

                      Text(
                        currentOrder.paymentStatus ?? "",
                        style: GoogleFonts.poppins(
                          fontSize: context.text14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.title,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      Text(
                        "Total Amount",
                        style: GoogleFonts.poppins(
                          fontSize: context.text14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.muted,
                        ),
                      ),

                      Text(
                        "₹${currentOrder.totalAmount}",
                        style: GoogleFonts.poppins(
                          fontSize: context.text18,
                          fontWeight: FontWeight.w700,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      Text(
                        "Order ID",
                        style: GoogleFonts.poppins(
                          fontSize: context.text14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.muted,
                        ),
                      ),

                      Text(
                        currentOrder.orderId ?? "",
                        style: GoogleFonts.poppins(
                          fontSize: context.text14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.title,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _activeOrderCard() {

    const steps = [
      {
        "label": "Placed",
        "icon": Icons.receipt_outlined,
      },

      {
        "label": "Packed",
        "icon": Icons.inventory_2_outlined,
      },

      {
        "label": "On Way",
        "icon": Icons.local_shipping_outlined,
      },

      {
        "label": "Delivered",
        "icon": Icons.home_outlined,
      },
    ];

    const doneUntil = 2;

    return Container(

      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: AppColor.primaryPale,
          width: 1,
        ),
      ),

      padding: const EdgeInsets.all(18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              const Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    "ORDER STATUS",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColor.muted,
                      letterSpacing: 1,
                    ),
                  ),

                  SizedBox(height: 3),

                  Text(
                    "Out for Delivery 🚚",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColor.title,
                    ),
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: AppColor.primaryPale,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Text(
                  "Active",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),

            child: const LinearProgressIndicator(
              value: 0.75,
              minHeight: 5,
              backgroundColor: AppColor.primaryPale,
              valueColor:
              AlwaysStoppedAnimation<Color>(
                AppColor.primary,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: List.generate(
              steps.length,

                  (i) {

                final done = i <= doneUntil;
                final current = i == doneUntil;

                return Column(
                  children: [

                    Container(
                      width: 34,
                      height: 34,

                      decoration: BoxDecoration(
                        color: done
                            ? AppColor.primary
                            : Colors.grey.shade100,

                        shape: BoxShape.circle,

                        border: current
                            ? Border.all(
                          color: AppColor.primaryLight,
                          width: 2,
                        )
                            : null,
                      ),

                      child: Icon(
                        steps[i]['icon'] as IconData,

                        size: 16,

                        color: done
                            ? Colors.white
                            : Colors.grey.shade400,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      steps[i]['label'] as String,

                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,

                        color: done
                            ? AppColor.primary
                            : AppColor.muted,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget orderItem(
      BuildContext context, {

        required int productId,

        required String image,

        required String name,

        required String des,

        required String productPrice,

        required double discountedPrice,

        required bool isOffer,
      }) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: AppCard(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.all(14),

        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Container(
              width: 70,
              height: 70,

              decoration: BoxDecoration(
                color: AppColor.surface,
                borderRadius: BorderRadius.circular(16),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),

                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    name,

                    style: GoogleFonts.poppins(
                      fontSize: context.text14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.title,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    des,

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: GoogleFonts.poppins(
                      fontSize: context.text12,
                      color: AppColor.muted,
                    ),
                  ),

                  const SizedBox(height: 8),

                  if (isOffer)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),

                      child: Text(
                        "50% OFF",

                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment:
              CrossAxisAlignment.end,

              children: [

                if (isOffer)
                  Text(
                    "₹$productPrice",

                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration:
                      TextDecoration.lineThrough,
                    ),
                  ),

                const SizedBox(height: 2),

                Text(
                  isOffer
                      ? "₹$discountedPrice"
                      : "₹$productPrice",

                  style: GoogleFonts.poppins(
                    fontSize: context.text16,
                    fontWeight: FontWeight.w700,
                    color: AppColor.title,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}