import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payplex_grocery_task/core/constant/app_size.dart';
import 'package:payplex_grocery_task/core/widget/app_card.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/widget/app_dilog.dart';
import '../../../routes/app_routes.dart';
import '../../auth/helper/auth_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final user = AuthPreferences.getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surface,
      body: Column(
        children: [
          Container(
            color: AppColor.primary,
            child: Stack(
              children: [
                Positioned(
                  top: -50,
                  right: -50,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.07),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 60,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 16,
                    left: 18,
                    right: 18,
                    bottom: 22,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 3,
                          ),
                        ),
                        child:  Center(
                          child: Text(

                            (() {
                              final name =
                              (user?['name'] ?? "Guest User")
                                  .toString()
                                  .trim();

                              final words =
                              name.split(' ');

                              if (words.length >= 2) {
                                return "${words[0][0]}${words[1][0]}"
                                    .toUpperCase();
                              }

                              return words[0][0].toUpperCase();
                            })(),

                            style: GoogleFonts.poppins(
                              fontSize: context.text20,
                              fontWeight: FontWeight.w800,
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                       Text(
                         (user?['name'] ?? "Guest User")
                             .toString().split(' ')
                             .map((e) => e.isNotEmpty
                               ? e[0].toUpperCase() +
                               e.substring(1) : '',
                         ).join(' '),
                        style: GoogleFonts.poppins(
                          fontSize: context.text20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: -0.4,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        "${user?['email']} · Pune, MH",
                        style: TextStyle(
                          fontSize: context.text12,
                          color: Colors.white.withOpacity(0.75),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Stats row
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            _stat("0", "Orders"),
                            _statDivider(),
                            _stat("₹0k", "Wallet"),
                            _statDivider(),
                            _stat("0", "Coins"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel("Shopping"),
                  const SizedBox(height: 8),
                  _menuGroup([
                    _MenuEntry(
                      icon: Icons.shopping_bag_outlined,
                      label: "My Orders",
                    ),
                    _MenuEntry(
                      icon: Icons.favorite_border,
                      label: "Wishlist",
                    ),
                    _MenuEntry(
                      icon: Icons.local_offer_outlined,
                      label: "My Coupons",
                      badge: "3 new",
                    ),
                  ]),

                  const SizedBox(height: 16),

                  _sectionLabel("Preferences"),
                  const SizedBox(height: 8),
                  _menuGroup([
                    _MenuEntry(
                      icon: Icons.location_on_outlined,
                      label: "Saved Address",
                    ),
                    _MenuEntry(
                      icon: Icons.notifications_none,
                      label: "Notifications",
                    ),
                  ]),

                  const SizedBox(height: 16),

                  _sectionLabel("Support"),
                  const SizedBox(height: 8),
                  _menuGroup([
                    _MenuEntry(
                      icon: Icons.help_outline,
                      label: "Help & Support",
                    ),
                    _MenuEntry(
                      icon: Icons.settings_outlined,
                      label: "Settings",
                    ),
                    _MenuEntry(
                      icon: Icons.info_outline,
                      label: "About FreshMart",
                    ),
                  ]),

                  const SizedBox(height: 18),

                  // Logout button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColor.red,
                        side: const BorderSide(
                            color: Color(0xFFFFDDDD), width: 1.5),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () async {

                        final confirm = await AppDialog.show(
                          context,
                          title: "Logout",
                          message: "Are you sure you want to logout?",
                          cancelText: "Cancel",
                          confirmText: "Logout",
                        );

                        if (confirm) {
                          await AuthPreferences.logout();
                          Get.offAllNamed(AppRoutes.login,);
                        }
                      },
                      icon: const Icon(Icons.logout, size: 20),
                      label: const Text(
                        "Log out",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statDivider() {
    return Container(
      width: 1,
      height: 36,
      color: Colors.white.withOpacity(0.2),
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppColor.muted,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _menuGroup(List<_MenuEntry> entries) {
    return AppCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      hasBorder: true,
      child: Column(
        children: List.generate(entries.length, (i) {
          final e = entries[i];
          return Column(
            children: [
              ListTile(
                leading: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColor.primaryPale,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(e.icon, color: AppColor.primary, size: 20),
                ),
                title: Text(
                  e.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColor.title,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (e.badge != null)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColor.primaryPale,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          e.badge!,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    const Icon(Icons.chevron_right,
                        color: AppColor.muted, size: 20),
                  ],
                ),
                onTap: () {},
              ),
              if (i < entries.length - 1)
                const Divider(
                  height: 1,
                  indent: 66,
                  color: AppColor.primaryPale,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _MenuEntry {
  final IconData icon;
  final String label;
  final String? badge;

  const _MenuEntry({
    required this.icon,
    required this.label,
    this.badge,
  });
}