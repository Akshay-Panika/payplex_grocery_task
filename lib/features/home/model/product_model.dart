class ProductModel {
  final int id;
  final int category;
  final CategoryDetails categoryDetails;
  final String productName;
  final String productImage;
  final double productPrice;
  final double discountedPrice;
  final String productDescription;
  final bool isOffer;
  final String createdAt;

  ProductModel({
    required this.id,
    required this.category,
    required this.categoryDetails,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.discountedPrice,
    required this.productDescription,
    required this.isOffer,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      category: json['category'] ?? 0,

      categoryDetails: CategoryDetails.fromJson(
        json['category_details'] ?? {},
      ),

      productName: json['product_name']?.toString() ?? '',
      productImage: json['product_image']?.toString() ?? '',

      // 🔥 SAFE PARSING (IMPORTANT FIX)
      productPrice: double.tryParse(
        json['product_price']?.toString() ?? '0',
      ) ??
          0.0,

      discountedPrice: double.tryParse(
        json['discounted_price']?.toString() ?? '0',
      ) ??
          0.0,

      productDescription: json['product_description']?.toString() ?? '',
      isOffer: json['isOffer'] ?? false,
      createdAt: json['created_at']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "category": category,
      "category_details": categoryDetails.toJson(),
      "product_name": productName,
      "product_image": productImage,
      "product_price": productPrice,
      "discounted_price": discountedPrice,
      "product_description": productDescription,
      "isOffer": isOffer,
      "created_at": createdAt,
    };
  }
}

class CategoryDetails {

  final int id;

  final String categoryName;

  final String categoryImage;

  final String createdAt;

  CategoryDetails({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
    required this.createdAt,
  });

  factory CategoryDetails.fromJson(
      Map<String, dynamic> json,
      ) {

    return CategoryDetails(

      id: json['id'] ?? 0,

      categoryName:
      json['category_name']?.toString() ?? '',

      categoryImage:
      json['category_image']?.toString() ?? '',

      createdAt:
      json['created_at']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {

    return {

      "id": id,

      "category_name": categoryName,

      "category_image": categoryImage,

      "created_at": createdAt,
    };
  }
}