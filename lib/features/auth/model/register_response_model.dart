// class RegisterResponse {
//   bool? status;
//   String? message;
//   Data? data;
//   Map<String, dynamic>? errors;
//
//   RegisterResponse({this.status, this.message, this.data, this.errors});
//
//   RegisterResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     errors = json['errors'];
//   }
// }
//
// class Data {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//
//   Data({this.id, this.name, this.email, this.phone});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//   }
// }