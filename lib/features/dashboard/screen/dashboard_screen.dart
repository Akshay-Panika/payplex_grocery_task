import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../core/constant/app_color.dart';
import '../../../routes/app_routes.dart';
import '../../History/screen/history_screen.dart';
import '../../account/screen/account_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../offers/screen/offer_screen.dart';
import '../../order/controller/cart_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final cartController = Get.find<CartController>();
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      const HomeScreen(),
      const OffersScreen(),
       HistoryScreen(),
      const AccountScreen(),
    ];
  }

  final List<_NavItem> _navItems = const [
    _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: "Home"),
    _NavItem(icon: Icons.local_offer_outlined, activeIcon: Icons.local_offer_rounded, label: "Offers"),
    _NavItem(icon: Icons.receipt_long_outlined, activeIcon: Icons.receipt_long_rounded, label: "Orders"),
    _NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: "Account"),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            border: const Border(
              top: BorderSide(color: AppColor.primaryPale, width: 1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              height: 60,
              child: Row(
                children: List.generate(_navItems.length, (i) {
                  final item = _navItems[i];
                  final active = _currentIndex == i;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _currentIndex = i),
                      behavior: HitTestBehavior.opaque,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 5),
                              decoration: BoxDecoration(
                                color: active
                                    ? AppColor.primaryPale
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                active ? item.activeIcon : item.icon,
                                color: active
                                    ? AppColor.primary
                                    : Colors.grey.shade400,
                                size: 22,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: active
                                    ? AppColor.primary
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),

        floatingActionButton: Obx(() {

          final cartCount = cartController.cartCount;

          if (cartCount == 0) {
            return const SizedBox();
          }

          return FloatingActionButton.extended(

            onPressed: () {

              print(
                  "Selected Product IDs => "
                      "${cartController.selectedProductIds}"
              );

              Get.toNamed(AppRoutes.orderDetails);
            },

            backgroundColor: AppColor.primary,

            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),

            label: Text(
              cartCount.toString(),

              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}