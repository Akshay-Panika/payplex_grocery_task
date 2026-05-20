class ApiEndpoint {
  static const String register = 'accounts/register/';
  static const String login = 'accounts/login/';
  static const String forgotPassword = 'accounts/forget-password/';
  static const String users = 'accounts/users/';
  static const String categoryList = 'category/list/';
  static const String productList = 'product/list/';

  static String createOrder(int userId) => "orders/create/$userId/";
  static String orderList(int userId) => "orders/list/$userId/";

  // static const String createOrder = 'orders/create/';
  // static const String orderList = 'orders/list/';

  static const String orderDelete = 'orders/delete/';
}