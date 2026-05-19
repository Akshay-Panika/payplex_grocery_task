import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payplex_grocery_task/core/widget/app_card.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../data/dummy_data.dart';
import '../../Order/screen/show_order_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
              top: MediaQuery.of(context).padding.top + 14,
              left: 18,
              right: 18,
              bottom: 16,
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order History 🧾",
                  style: GoogleFonts.poppins(
                    fontSize: context.text20,
                    fontWeight: FontWeight.w700,
                    color: AppColor.title,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "All your past orders in one place",
                  style: TextStyle(fontSize: 14, color: AppColor.muted),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
              
            
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final order = DummyData.orderHistory[index];
                        final delivered = order['status'] == 'Delivered';
            
                        return AppCard(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowOrderScreen(),));
                          },
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            leading: Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: delivered
                                    ? AppColor.primaryPale
                                    : const Color(0xFFFFEBEB),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Icon(
                                delivered
                                    ? Icons.shopping_bag_outlined
                                    : Icons.cancel_outlined,
                                color: delivered ? AppColor.primary : AppColor.red,
                                size: 22,
                              ),
                            ),
                            title: Text(
                              "Order #${order['id']}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColor.title,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 2),
                                Text(
                                  order['items']!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColor.muted,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: delivered
                                        ? AppColor.primaryPale
                                        : const Color(0xFFFFEBEB),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    delivered ? "✓ Delivered" : "✕ Cancelled",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: delivered ? AppColor.primary : AppColor.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Text(
                              order['price']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColor.title,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: DummyData.orderHistory.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}