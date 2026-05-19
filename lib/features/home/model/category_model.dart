class CategoryModel {

  final int id;
  final String categoryName;
  final String categoryImage;
  final String createdAt;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
    required this.createdAt,
  });

  factory CategoryModel.fromJson(
      Map<String, dynamic> json,
      ) {

    return CategoryModel(
      id: json['id'],
      categoryName: json['category_name'] ?? '',
      categoryImage: json['category_image'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}