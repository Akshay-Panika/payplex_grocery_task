import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/widget/app_card.dart';
import '../../home/controller/product_controller.dart';
import '../../order/controller/cart_controller.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {

  final productController = Get.find<ProductController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.surface,

      body: Column(
        children: [

          /// HEADER
          Container(
            width: double.infinity,
            color: AppColor.white,

            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              left: 18,
              right: 18,
              bottom: 18,
            ),

            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Special Offers 🎁",

                      style: GoogleFonts.poppins(
                        fontSize: context.text20,
                        fontWeight: FontWeight.w700,
                        color: AppColor.title,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Handpicked deals just for you",

                      style: GoogleFonts.poppins(
                        fontSize: context.text12,
                        color: AppColor.muted,
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: AppColor.primaryPale,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: const Icon(
                    Icons.local_offer,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
          ),

          /// OFFERS LIST
          Expanded(
            child: Obx(() {

              final offers = productController.productList
                  .where((e) => e.isOffer == true)
                  .toList();

              if (productController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (offers.isEmpty) {
                return AppCard(
                  color: Colors.transparent,
                  height: context.sHeight*0.3,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          color: AppColor.primaryPale,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search_off_rounded,
                          size: 38,
                          color: AppColor.muted,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "No products found",
                        style: GoogleFonts.poppins(
                          fontSize: context.text16,
                          fontWeight: FontWeight.w600,
                          color: AppColor.title,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "This category doesn't have\nany items right now.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: context.text12,
                          color: AppColor.muted,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  14,
                  14,
                  14,
                  20,
                ),

                itemCount: offers.length,

                itemBuilder: (context, index) {

                  final product = offers[index];

                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 16,
                    ),

                    decoration: BoxDecoration(
                      color: AppColor.white,

                      borderRadius:
                      BorderRadius.circular(26),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.04),

                          blurRadius: 12,

                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        /// IMAGE SECTION
                        Container(
                          height: context.sHeight * 0.22,
                          width: double.infinity,

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                            const BorderRadius.vertical(
                              top: Radius.circular(26),
                            ),
                          ),

                          child: Stack(
                            children: [

                              Positioned(
                                top: 14,
                                left: 14,

                                child: Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),

                                  decoration: BoxDecoration(
                                    color: AppColor.primary.withOpacity(.2),

                                    borderRadius:
                                    BorderRadius.circular(30),
                                  ),

                                  child: Text(
                                    "50% OFF",

                                    style:
                                    GoogleFonts.poppins(
                                      fontSize:
                                      context.text10,

                                      fontWeight:
                                      FontWeight.w600,

                                      color:
                                      AppColor.primary,
                                    ),
                                  ),
                                ),
                              ),

                              Center(
                                child: Image.network(
                                  product.productImage,

                                  height:
                                  context.sHeight * 0.14,

                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// CONTENT
                        Padding(
                          padding:
                          const EdgeInsets.all(16),

                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                product.productName,

                                style:
                                GoogleFonts.poppins(
                                  fontSize:
                                  context.text16,

                                  fontWeight:
                                  FontWeight.w700,

                                  color:
                                  AppColor.title,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                product.productDescription,

                                maxLines: 2,

                                overflow:
                                TextOverflow.ellipsis,

                                style:
                                GoogleFonts.poppins(
                                  fontSize:
                                  context.text12,

                                  color:
                                  AppColor.muted,

                                  height: 1.5,
                                ),
                              ),

                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,

                                children: [

                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                    children: [

                                      /// DISCOUNT PRICE
                                      Text(
                                        "₹${product.discountedPrice.toStringAsFixed(0)}",

                                        style:
                                        GoogleFonts.poppins(
                                          fontSize:
                                          context.text18,

                                          fontWeight:
                                          FontWeight.w700,

                                          color:
                                          AppColor.primary,
                                        ),
                                      ),

                                      const SizedBox(height: 2),

                                      /// ORIGINAL PRICE
                                      Text(
                                        "₹${product.productPrice.toStringAsFixed(0)}",

                                        style:
                                        GoogleFonts.poppins(
                                          fontSize:
                                          context.text12,

                                          color:
                                          AppColor.muted,

                                          decoration:
                                          TextDecoration
                                              .lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),

                                  /// ADD BUTTON
                                  Obx(() {

                                    final added =
                                    cartController.isAdded(product.id);

                                    return AppCard(
                                      onTap: () {
                                        cartController.toggleProduct(product.id);
                                      },

                                      color: added
                                          ? AppColor.primaryPale
                                          : AppColor.primary,

                                      child: Icon(
                                        added
                                            ? Icons.check
                                            : Icons.add,

                                        color: added
                                            ? AppColor.primary
                                            : Colors.white,

                                        size: 24,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}