import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payplex_grocery_task/core/constant/app_size.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/utils/safe_network_image.dart';
import '../../../core/widget/app_card.dart';
import '../../auth/helper/auth_preferences.dart';
import '../../order/controller/cart_controller.dart';
import '../controller/category_controller.dart';
import '../controller/product_controller.dart';
import '../model/product_model.dart';
import '../widget/banner_widget.dart';
import '../widget/search_widget.dart';
import 'package:shimmer/shimmer.dart'; // ← yeh add karo

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = AuthPreferences.getUser();
  final categoryController = Get.find<CategoryController>();
  final productController = Get.find<ProductController>();
  final cartController = Get.find<CartController>();
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surface,
      body: SafeArea(
        child:RefreshIndicator(

          onRefresh: () async {
            categoryController.getCategories();
            productController.getProducts();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(
                    left: context.sWidth * 0.03,
                    right: context.sWidth * 0.03,
                    bottom: context.sWidth * 0.03,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: AppColor.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Pune, Maharashtra",
                                  style: GoogleFonts.poppins(
                                    fontSize: context.text12,
                                    color: AppColor.muted,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: context.sWidth * 0.01),

                            Text(
                              (user?['name'] ?? "Guest User")
                                  .toString()
                                  .split(' ')
                                  .map(
                                    (e) => e.isNotEmpty
                                        ? e[0].toUpperCase() + e.substring(1)
                                        : '',
                                  )
                                  .join(' '),
                              style: GoogleFonts.poppins(
                                fontSize: context.text20,
                                fontWeight: FontWeight.w600,
                                color: AppColor.title,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColor.primaryPale,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                (() {
                                  final name = (user?['name'] ?? "Guest User")
                                      .toString()
                                      .trim();

                                  final words = name.split(' ');

                                  if (words.length >= 2) {
                                    return "${words[0][0]}${words[1][0]}"
                                        .toUpperCase();
                                  }

                                  return words[0][0].toUpperCase();
                                })(),

                                style: GoogleFonts.poppins(
                                  fontSize: context.text14,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 1,
                            top: 1,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverSearchBarDelegate(
                  height: context.sWidth * 0.12,
                  child: SearchWidget(),
                ),
              ),

              SliverToBoxAdapter(child: BannerWidget()),

              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverSearchBarDelegate(
                  height: context.sWidth * 0.36,
                  child: Padding(
                    padding: EdgeInsets.only(top: 18, bottom: 10),
                    child: Column(
                      spacing: 10,
                      children: [
                        Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Categories",
                              style: GoogleFonts.poppins(
                                fontSize: context.text14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.title,
                              ),
                            ),
                            Obx(() {
                              if (categoryController.isLoading.value) {
                                return SizedBox(
                                  height: context.sHeight*0.05,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 8),
                                    itemBuilder: (context, _) =>
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(
                                                8,
                                              ),
                                            ),
                                          ),
                                        ),
                                  ),
                                );
                              }

                              final categories = [
                                {"id": 0, "name": "All", "image": ""},

                                ...categoryController.categoryList.map(
                                  (e) => {
                                    "id": e.id,
                                    "name": e.categoryName,
                                    "image": e.categoryImage,
                                  },
                                ),
                              ];

                              return SizedBox(
                                height: context.sHeight*0.05,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 8),
                                  itemBuilder: (context, index) {
                                    final category = categories[index];
                                    final selected =
                                        selectedCategoryIndex == index;

                                    return AppCard(
                                      onTap: () {
                                        setState(() {
                                          selectedCategoryIndex = index;
                                        });
                                      },
                                      color: selected
                                          ? AppColor.primary
                                          : AppColor.white,

                                      hasBorder: true,
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: context.sWidth * 0.03,
                                      ),
                                      child: Row(
                                        children: [
                                          if (index != 0)
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: SafeNetworkImage(
                                                imageUrl:category['image'].toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          Text(
                                            category['name'].toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: context.text12,
                                              fontWeight: FontWeight.w600,
                                              color: selected
                                                  ? Colors.white
                                                  : AppColor.muted,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Fresh Picks",
                              style: GoogleFonts.poppins(
                                fontSize: context.text16,
                                fontWeight: FontWeight.w700,
                                color: AppColor.title,
                              ),
                            ),
                            Text(
                              "See all",
                              style: GoogleFonts.poppins(
                                fontSize: context.text12,
                                fontWeight: FontWeight.w600,
                                color: AppColor.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Obx(() {
                if (productController.isLoading.value) {
                  return SliverPadding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, _) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        childCount: 6, // 6 fake cards dikhaega
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.8,
                          ),
                    ),
                  );
                }

                final allProducts = productController.productList;
                List<ProductModel> filteredProducts = [];

                if (selectedCategoryIndex == 0) {
                  filteredProducts = allProducts;
                } else {
                  final selectedCategory =
                      categoryController.categoryList[selectedCategoryIndex - 1];

                  filteredProducts = allProducts.where((product) {
                    return product.category == selectedCategory.id;
                  }).toList();
                }

                if (filteredProducts.isEmpty) {
                  return SliverToBoxAdapter(
                    child: AppCard(
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
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {

                      final product = filteredProducts[index];

                      return AppCard(
                        padding: EdgeInsets.zero,
                        hasBorder: false,
                        margin: EdgeInsets.zero,

                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [

                            Expanded(
                              child: SafeNetworkImage(
                                imageUrl: product.productImage,
                                fit: BoxFit.fill,
                                width: double.infinity,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  Text(
                                    product.productName,

                                    style: GoogleFonts.poppins(
                                      fontSize: context.text14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.title,
                                    ),

                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    product.productDescription,

                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColor.muted,
                                    ),

                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(height: 8),

                                  Row(
                                    children: [

                                      /// ORIGINAL PRICE
                                      if (product.isOffer == true)
                                        Text(
                                        '₹${product.productPrice.toStringAsFixed(0)}',

                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),

                                      if (product.isOffer == true)
                                        const SizedBox(width: 6),

                                      /// DISCOUNT PRICE
                                      Text(
                                        product.isOffer
                                            ? '₹${product.discountedPrice.toStringAsFixed(0)}'
                                            : '₹${product.productPrice.toStringAsFixed(0)}',

                                        style: GoogleFonts.poppins(
                                          fontSize: context.text16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.title,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                    children: [

                                      /// OFFER TEXT
                                      if (product.isOffer == true)
                                        Text(
                                          '50% OFF',

                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green,
                                          ),
                                        )
                                      else
                                        const SizedBox(),

                                      /// ADD BUTTON
                                      Obx(() {

                                        final added = cartController.isAdded(product.id);

                                        return AppCard(
                                          onTap: () {
                                            cartController.toggleProduct(product.id);
                                          },

                                          color: added
                                              ? AppColor.primaryPale
                                              : AppColor.primary,

                                          margin: EdgeInsets.zero,

                                          child: Icon(
                                            added
                                                ? Icons.check
                                                : Icons.add,

                                            color: added
                                                ? AppColor.primary
                                                : Colors.white,

                                            size: 18,
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

                      childCount: filteredProducts.length,
                    ),

                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Key? key;
  _SliverSearchBarDelegate({
    required this.child,
    required this.height,
    this.color,
    this.padding,
    this.key,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(
      key: key,
      height: height,
      child: Container(
        color: color ?? AppColor.surface,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 12),
        child: child,
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _SliverSearchBarDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
