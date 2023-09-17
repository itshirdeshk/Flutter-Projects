import 'package:ecommerce_frontend/data/models/order/order_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayServices {
  static final _instance = Razorpay();

  static Future<void> checkoutOrder(
    OrderModel orderModel, {
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
  }) async {
    var options = {
      'key': 'rzp_test_NsSDhF64BvkIY3',
      'order_id': '${orderModel.razorpayOrderId}',
      'name': 'Ecommerce App',
      'description': "${orderModel.sId}",
      'prefill': {'email': "${orderModel.user!.email}"}
    };

    _instance.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      onSuccess(response);
      _instance.clear();
    });

    _instance.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      onFailure(response);
      _instance.clear();
    });

    _instance.open(options);
  }
}
