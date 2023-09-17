import 'package:ecommerce_frontend/data/models/cart/cart_item_model.dart';
import 'package:ecommerce_frontend/data/models/user/user_model.dart';
import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  UserModel? user;
  List<CartItemModel>? items;
  String? status;
  String? sId;
  double? totalAmount;
  String? razorpayOrderId;
  DateTime? updatedOn;
  DateTime? createdOn;

  OrderModel({
    this.user,
    this.items,
    this.status,
    this.sId,
    this.updatedOn,
    this.createdOn,
    this.totalAmount,
    this.razorpayOrderId,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    user = UserModel.fromJson(json['user']);
    items = (json['items'] as List<dynamic>)
        .map((item) => CartItemModel.fromJson(item))
        .toList();
    totalAmount = double.tryParse(json['totalAmount'].toString());
    razorpayOrderId = json['razorpayOrderId'];
    updatedOn = DateTime.tryParse(json['updatedOn']);
    createdOn = DateTime.tryParse(json['createdOn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['user'] = user!.toJson();
    data['items'] =
        items!.map((item) => item.toJson(objectMode: true)).toList();
    data['_id'] = sId;
    data['razorpayOrderId'] = razorpayOrderId;
    data['totalAmount'] = totalAmount;
    data['updatedOn'] = updatedOn!.toIso8601String();
    data['createdOn'] = createdOn!.toIso8601String();
    return data;
  }

  @override
  List<Object?> get props => [sId];
}
