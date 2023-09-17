import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/data/models/order/order_model.dart';

import '../../core/api.dart';

class OrderRepository {
  final _api = Api();
  Future<List<OrderModel>> fetchOrderForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get(
        '/order/$userId',
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Convert raw data to model
      return (apiResponse.data as List<dynamic>)
          .map((json) => OrderModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<OrderModel> createOrder(OrderModel orderModel) async {
    try {
      Response response = await _api.sendRequest
          .post('/order', data: jsonEncode(orderModel.toJson()));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Convert raw data to model
      return OrderModel.fromJson(apiResponse.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<OrderModel> updateOrder(OrderModel orderModel, {String? paymentId, String? signature}) async {
    try {
      Response response = await _api.sendRequest
          .put('/order/updateStatus', data: jsonEncode({
            'orderId' : orderModel.sId,
            'status' : orderModel.status,
            'razorpayPaymentId' : paymentId,
            'razorpaySignature' : signature,
          }));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Convert raw data to model
      return OrderModel.fromJson(apiResponse.data);
    } catch (e) {
      rethrow;
    }
  }

  
}
