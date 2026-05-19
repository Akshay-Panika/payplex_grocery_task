import 'package:flutter/material.dart';
import 'package:payplex_grocery_task/core/widget/my_appbar.dart';
import '../../../core/constant/app_color.dart';

class ShowOrderScreen extends StatelessWidget {
  const ShowOrderScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surface,
      appBar: myAppBar(title: '',
        showBackButton: true
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: AppColor.white,
              padding: EdgeInsets.only(

                left: 18,
                right: 18,
                bottom: 16,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Show Orders 📦",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColor.title,
                      letterSpacing: -0.6,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Stay updated on your deliveries",
                    style: TextStyle(fontSize: 14, color: AppColor.muted),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: _activeOrderCard(context),
            ),
          ),

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

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _orderItem("🍎", "Fresh Apple", "2 KG", "₹240"),
                const SizedBox(height: 10),
                _orderItem("🥛", "Milk", "2 L", "₹120"),
                const SizedBox(height: 16),
                _totalCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _activeOrderCard(BuildContext context) {
    const steps = [
      {"label": "Placed", "icon": Icons.receipt_outlined},
      {"label": "Packed", "icon": Icons.inventory_2_outlined},
      {"label": "On Way", "icon": Icons.local_shipping_outlined},
      {"label": "Delivered", "icon": Icons.home_outlined},
    ];
    const doneUntil = 2;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.primaryPale, width: 1),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ORDER #1052",
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.75,
              minHeight: 5,
              backgroundColor: AppColor.primaryPale,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColor.primary),
            ),
          ),

          const SizedBox(height: 20),

          // Steps
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (i) {
              final done = i <= doneUntil;
              final current = i == doneUntil;
              return Column(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: done ? AppColor.primary : Colors.grey.shade100,
                      shape: BoxShape.circle,
                      border: current
                          ? Border.all(color: AppColor.primaryLight, width: 2)
                          : null,
                    ),
                    child: Icon(
                      steps[i]['icon'] as IconData,
                      size: 16,
                      color: done ? Colors.white : Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    steps[i]['label'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: done ? AppColor.primary : AppColor.muted,
                    ),
                  ),
                ],
              );
            }),
          ),

          const SizedBox(height: 14),
          const Divider(color: AppColor.primaryPale),
          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: AppColor.primary),
              const SizedBox(width: 6),
              Text(
                "Estimated arrival: ",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),
              const Text(
                "Today, 6:30 PM",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColor.title,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _orderItem(String emoji, String name, String qty, String price) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.primaryPale, width: 1),
      ),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColor.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 22))),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColor.title,
          ),
        ),
        subtitle: Text(qty,
            style: const TextStyle(fontSize: 13, color: AppColor.muted)),
        trailing: Text(
          price,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColor.title,
          ),
        ),
      ),
    );
  }

  Widget _totalCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.primaryPale,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Amount",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.primary,
            ),
          ),
          Text(
            "₹360",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColor.primary,
            ),
          ),
        ],
      ),
    );
  }
}

