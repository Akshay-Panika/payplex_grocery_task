import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payplex_grocery_task/core/constant/app_color.dart';
import 'package:payplex_grocery_task/core/constant/app_size.dart';
import 'package:payplex_grocery_task/core/widget/app_card.dart';
import 'package:payplex_grocery_task/core/widget/my_appbar.dart';
import '../../../routes/app_routes.dart';
import '../../home/controller/product_controller.dart';
import 'package:payplex_grocery_task/features/order/controller/cart_controller.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final productController = Get.find<ProductController>();
  final cartController = Get.find<CartController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surface,

      appBar: myAppBar(
        title: 'Order Details',
        showBackButton: true,
      ),
      
      body:  Obx(() {
        if (productController.isLoading.value) {
          return CircularProgressIndicator();
        }

        final selectedProducts = productController.productList.where((product) {
          return cartController.selectedProductIds.contains(product.id);
        }).toList();

        double subtotal = 0;

        for (var product in selectedProducts) {

          subtotal += product.isOffer
              ? product.discountedPrice
              : product.productPrice.toInt();
        }

        double deliveryFee = 0;

        double total = subtotal + deliveryFee;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
              
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
              
                    children: [
              
                      /// Address Card
                      AppCard(
                        margin: EdgeInsets.zero,
                        padding: const EdgeInsets.all(16),
              
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
              
                          children: [
              
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: AppColor.primaryPale,
                                borderRadius:
                                BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: AppColor.primary,
                              ),
                            ),
              
                            const SizedBox(width: 14),
              
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
              
                                children: [
              
                                  Text(
                                    "Delivery Address",
                                    style: GoogleFonts.poppins(
                                      fontSize:
                                      context.text14,
                                      fontWeight:
                                      FontWeight.w600,
                                      color:
                                      AppColor.title,
                                    ),
                                  ),
              
                                  const SizedBox(height: 4),
              
                                  Text(
                                    "Pune, Maharashtra, India",
                                    style: GoogleFonts.poppins(
                                      fontSize:
                                      context.text12,
                                      color:
                                      AppColor.muted,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
              
                            TextButton(
                              onPressed: () {},
              
                              child: Text(
                                "Change",
                                style: GoogleFonts.poppins(
                                  color:
                                  AppColor.primary,
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              
                      if(total !=0)
                      const SizedBox(height: 22),
              
                      /// Items Header
                      if(total !=0)
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
              
                        children: [
              
                          Text(
                            "Your Items",
                            style: GoogleFonts.poppins(
                              fontSize: context.text18,
                              fontWeight: FontWeight.w700,
                              color: AppColor.title,
                            ),
                          ),
              
                          Text(
                            "${cartController.cartCount} Items",
                            style: GoogleFonts.poppins(
                              fontSize: context.text12,
                              color: AppColor.title,
                            ),
                          ),
                        ],
                      ),
                      if(total !=0)
                      const SizedBox(height: 16),
              
                      /// Items
                      Column(
                        children: List.generate(
                            selectedProducts.length,
                              (index) {
              
                                final product = selectedProducts[index];
              
                            return orderItem(
                              context,
                              productId: product.id,
                              image: product.productImage,
                              name: product.productName,
                              des: product.productDescription,
                              productPrice: product.productPrice.toStringAsFixed(0),
                              discountedPrice: product.discountedPrice.toStringAsFixed(0),
                              isOffer: product.isOffer,
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                    ],
                  ),
                ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                   padding: const EdgeInsets.all(10),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       /// Payment Summary
                       Text(
                         "Payment Summary",
                         style: GoogleFonts.poppins(
                           fontSize: context.text18,
                           fontWeight: FontWeight.w700,
                           color: AppColor.title,
                         ),
                       ),

                       const SizedBox(height: 14),

                       AppCard(
                         margin: EdgeInsets.zero,
                         padding: const EdgeInsets.all(16),

                         child: Column(
                           children: [

                             priceRow(
                               "Subtotal",
                               "₹${total.toStringAsFixed(0)}",
                             ),

                             const SizedBox(height: 10),

                             priceRow(
                               "Delivery Fee",
                               "Free",
                             ),

                             const Padding(
                               padding:
                               EdgeInsets.symmetric(
                                 vertical: 14,
                               ),
                               child: Divider(
                                 height: 1,
                               ),
                             ),

                             priceRow(
                               "Total",
                               "₹${total.toStringAsFixed(0)}",
                               isBold: true,
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    border: Border(
                      top: BorderSide(
                        color: AppColor.primaryPale,
                      ),
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [

                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              Text(
                                "Total Price",
                                style: GoogleFonts.poppins(
                                  fontSize: context.text12,
                                  color: AppColor.muted,
                                ),
                              ),

                              Text(
                                "₹${total.toStringAsFixed(0)}",
                                style: GoogleFonts.poppins(
                                  fontSize: context.text22,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.title,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: SizedBox(
                            height: 54,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed(
                                  AppRoutes.payment,
                                  arguments: {
                                    "totalAmount": total.toString(),
                                  },
                                );
                                },

                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                AppColor.primary,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(18),
                                ),
                              ),

                              child: Text(
                                "Place Order",
                                style: GoogleFonts.poppins(
                                  fontSize: context.text14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        );
        }
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
        required String discountedPrice,
        required bool isOffer,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: AppCard(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.all(14),

        child: Row(
          children: [

            Container(
              width: 62,
              height: 62,
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

                  const SizedBox(height: 6),

                  /// OFFER TEXT
                  if (isOffer)
                    Text(
                      "50% OFF",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment:
              CrossAxisAlignment.end,

              children: [

                /// ORIGINAL PRICE
                if (isOffer)
                  Text(
                    "₹$productPrice",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),

                if (isOffer)
                  const SizedBox(height: 2),

                /// FINAL PRICE
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

                const SizedBox(height: 6),

                AppCard(
                  onTap: () {
                    cartController.toggleProduct(productId);
                  },
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  color: AppColor.primaryPale,
                  margin: EdgeInsets.zero,
                  child: Text(
                    "Remove",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget priceRow(
      String title,
      String value, {
        bool isBold = false,
      }) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

      children: [

        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: isBold
                ? AppColor.title
                : AppColor.muted,
            fontWeight: isBold
                ? FontWeight.w600
                : FontWeight.w500,
          ),
        ),

        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColor.title,
            fontWeight: isBold
                ? FontWeight.w700
                : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}