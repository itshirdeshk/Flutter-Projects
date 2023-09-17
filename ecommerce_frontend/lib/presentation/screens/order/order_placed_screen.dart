import 'package:ecommerce_frontend/core/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});

  static const String routeName = 'order_placed';

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Placed!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.cube_box_fill,
              color: AppColors.textLight,
              size: 100,
            ),
            Text(
              'Order Placed!',
              style: TextStyles.heading3.copyWith(color: AppColors.textLight),
            ),
          ],
        ),
      ),
    );
  }
}
