import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payplex_grocery_task/core/constant/app_color.dart';
import 'package:payplex_grocery_task/core/constant/app_size.dart';
import 'package:payplex_grocery_task/core/widget/app_card.dart';
import '../../../core/widget/app_button.dart';
import '../../../core/widget/my_appbar.dart';
import '../../../routes/app_routes.dart';
import '../../order/controller/cart_controller.dart';
import '../../order/controller/order_controller.dart';

class PaymentScreen extends StatefulWidget {
  final String totalAmount;
  const PaymentScreen({super.key, required this.totalAmount});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  int selectedIndex = 0;
  final  orderController = Get.find<OrderController>();
  final  cartController = Get.find<CartController>();

  final List<Map<String, dynamic>> payments = [
    {
      "icon": Icons.account_balance_wallet,
      "title": "Google Pay",
      "subtitle": "Pay using UPI apps",
    },
    {
      "icon": Icons.credit_card,
      "title": "Credit / Debit Card",
      "subtitle": "Visa, Mastercard, Rupay",
    },
    {
      "icon": Icons.money,
      "title": "Cash On Delivery",
      "subtitle": "Pay after delivery",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surface,

      appBar: myAppBar(
        title: "Payment",
        showBackButton: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(
              "Choose Payment Method",
              style: GoogleFonts.poppins(
                fontSize: context.text18,
                fontWeight: FontWeight.w700,
                color: AppColor.title,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: payments.length,

                itemBuilder: (context, index) {

                  final item = payments[index];
                  final selected =
                      selectedIndex == index;

                  return paymentTile(
                    icon: item["icon"],
                    title: item["title"],
                    subtitle: item["subtitle"],
                    selected: selected,

                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                },
              ),
            ),

            AppCard(
              hasBorder: true,
              padding: const EdgeInsets.all(18),
              margin: EdgeInsets.zero,
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                    children: [

                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(
                            "Total Amount",
                            style:
                            GoogleFonts.poppins(
                              fontSize:
                              context.text12,
                              color:
                              AppColor.muted,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "₹${widget.totalAmount}",
                            style:
                            GoogleFonts.poppins(
                              fontWeight:
                              FontWeight.w700,
                              fontSize:
                              context.text20,
                              color:
                              AppColor.title,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Obx(() {

                    return AppButton(

                      text: "Pay Now",

                      isLoading:
                      orderController
                          .isCreateOrderLoading
                          .value,

                      onPressed: () async {

                        // SELECTED PAYMENT METHOD
                        final paymentStatus =
                        payments[selectedIndex]["title"];

                        // API CALL
                        await orderController.createOrder(

                          items: cartController.selectedProductIds,

                          totalAmount: widget.totalAmount.toString(),
                          paymentStatus: paymentStatus,
                        );
                        if (orderController
                            .createOrderModel != null) {

                          showDialog(
                            context: context,

                            barrierDismissible: false,

                            builder: (context) {

                              return AlertDialog(

                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),

                                content: Column(

                                  mainAxisSize:
                                  MainAxisSize.min,

                                  children: [

                                    Container(

                                      width: 70,
                                      height: 70,

                                      decoration:
                                      BoxDecoration(
                                        color: Colors
                                            .green
                                            .shade50,

                                        shape:
                                        BoxShape.circle,
                                      ),

                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 40,
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    Text(
                                      "Payment Successful",

                                      style:
                                      GoogleFonts.poppins(
                                        fontSize:
                                        context.text18,

                                        fontWeight:
                                        FontWeight.w700,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      "Your order has been placed successfully.",

                                      textAlign:
                                      TextAlign.center,

                                      style:
                                      GoogleFonts.poppins(
                                        fontSize:
                                        context.text12,

                                        color:
                                        AppColor.muted,
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    Text(
                                      "Payment : $paymentStatus",

                                      style:
                                      GoogleFonts.poppins(
                                        fontSize:
                                        context.text14,

                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      "Order ID : ${orderController.createOrderModel?.orderId ?? ""}",

                                      style:
                                      GoogleFonts.poppins(
                                        fontSize:
                                        context.text14,

                                        fontWeight:
                                        FontWeight.w700,
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    SizedBox(

                                      width:
                                      double.infinity,

                                      child: AppButton(

                                        text: "Go To Home",

                                        onPressed: () {

                                          // DIALOG CLOSE
                                          Navigator.pop(context);

                                          // DASHBOARD OPEN
                                          Get.offAllNamed(AppRoutes.dashboard);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
        const Duration(milliseconds: 200),

        margin: const EdgeInsets.only(
          bottom: 14,
        ),

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: AppColor.white,

          borderRadius:
          BorderRadius.circular(20),

          border: Border.all(
            color: selected
                ? AppColor.primary
                : Colors.grey.shade200,

            width: selected ? 1.6 : 1,
          ),

          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [

            Container(
              width: 54,
              height: 54,

              decoration: BoxDecoration(
                color: selected
                    ? AppColor.primaryPale
                    : Colors.grey.shade100,

                borderRadius:
                BorderRadius.circular(16),
              ),

              child: Icon(
                icon,
                color: selected
                    ? AppColor.primary
                    : AppColor.title,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    style:
                    GoogleFonts.poppins(
                      fontWeight:
                      FontWeight.w600,
                      fontSize:
                      context.text14,
                      color:
                      AppColor.title,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style:
                    GoogleFonts.poppins(
                      fontSize:
                      context.text12,
                      color:
                      AppColor.muted,
                    ),
                  ),
                ],
              ),
            ),

            AnimatedContainer(
              duration:
              const Duration(milliseconds: 200),

              width: 24,
              height: 24,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                border: Border.all(
                  color: selected
                      ? AppColor.primary
                      : Colors.grey.shade400,
                  width: 2,
                ),

                color: selected
                    ? AppColor.primary
                    : Colors.transparent,
              ),

              child: selected
                  ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 14,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}