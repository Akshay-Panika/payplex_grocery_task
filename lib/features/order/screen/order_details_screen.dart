import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payplex_grocery_task/core/constant/app_color.dart';
import 'package:payplex_grocery_task/core/constant/app_size.dart';
import 'package:payplex_grocery_task/core/widget/app_card.dart';
import 'package:payplex_grocery_task/core/widget/my_appbar.dart';
import 'package:payplex_grocery_task/features/Payment/screen/payment_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surface,

      appBar: myAppBar(
        title: 'Order Details',
        showBackButton: true,
      ),

      bottomNavigationBar: Container(
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
                      "₹360",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(),));
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

      body: SingleChildScrollView(
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

            const SizedBox(height: 22),

            /// Items Header
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
                  "2 Items",
                  style: GoogleFonts.poppins(
                    fontSize: context.text12,
                    color: AppColor.muted,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Items
            orderItem(
              context,
              emoji: "🍎",
              name: "Fresh Apple",
              qty: "2 KG",
              price: "₹240",
            ),

            orderItem(
              context,
              emoji: "🥛",
              name: "Fresh Milk",
              qty: "2 L",
              price: "₹120",
            ),

            const SizedBox(height: 24),

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
                    "₹360",
                  ),

                  const SizedBox(height: 10),

                  priceRow(
                    "Delivery Fee",
                    "₹40",
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
                    "₹400",
                    isBold: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderItem(
      BuildContext context, {
        required String emoji,
        required String name,
        required String qty,
        required String price,
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
                borderRadius:
                BorderRadius.circular(16),
              ),

              child: Center(
                child: Text(
                  emoji,
                  style:
                  const TextStyle(fontSize: 30),
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
                    qty,
                    style: GoogleFonts.poppins(
                      fontSize:
                      context.text12,
                      color:
                      AppColor.muted,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment:
              CrossAxisAlignment.end,

              children: [

                Text(
                  price,
                  style: GoogleFonts.poppins(
                    fontSize:
                    context.text16,
                    fontWeight:
                    FontWeight.w700,
                    color:
                    AppColor.title,
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                    AppColor.primaryPale,
                    borderRadius:
                    BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    "Added",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight:
                      FontWeight.w600,
                      color:
                      AppColor.primary,
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