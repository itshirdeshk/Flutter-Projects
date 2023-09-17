import 'dart:developer';

import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/data/models/order/order_model.dart';
import 'package:ecommerce_frontend/data/models/user/user_model.dart';
import 'package:ecommerce_frontend/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_frontend/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce_frontend/logic/cubits/order_cubit/order_cubit.dart';
import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce_frontend/logic/services/razorpay.dart';
import 'package:ecommerce_frontend/presentation/screens/order/order_placed_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/order/provider/order_detail_provider.dart';
import 'package:ecommerce_frontend/presentation/screens/user/edit_profile_screen.dart';
import 'package:ecommerce_frontend/presentation/widgets/cart_listview_builder.dart';
import 'package:ecommerce_frontend/presentation/widgets/gap_widget.dart';
import 'package:ecommerce_frontend/presentation/widgets/link_button.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  static const String routeName = 'order_detail';

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Order'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return const CircularProgressIndicator();
              }

              if (state is UserLogggedInState) {
                UserModel user = state.userModel;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User',
                      style: TextStyles.body1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const GapWidget(),
                    Text(
                      '${user.fullName}',
                      style: TextStyles.heading3,
                    ),
                    Text(
                      'Email: ${user.email}',
                      style: TextStyles.body2,
                    ),
                    Text(
                      'Address: ${user.address}, ${user.city}, ${user.state}, ',
                      style: TextStyles.body2,
                    ),
                    LinkButton(
                      text: "Edit Profile",
                      onPressed: () {
                        Navigator.pushNamed(
                            context, EditProfileScreen.routeName);
                      },
                    )
                  ],
                );
              }

              if (state is UserErrorState) {
                return Text(state.message);
              }

              return const SizedBox();
            },
          ),
          const GapWidget(
            size: 10,
          ),
          Text(
            'Items',
            style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),
          ),
          const GapWidget(),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLodingState && state.items.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is CartErrorState && state.items.isEmpty) {
                return Text(state.message);
              }

              return CartListView(
                items: state.items,
                shrinkWrap: true,
                noScroll: true,
              );
            },
          ),
          Text(
            'Payment',
            style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),
          ),
          const GapWidget(),
          Consumer<OrderDetailProvider>(builder: (context, provider, child) {
            return Column(
              children: [
                RadioListTile(
                    value: 'pay-on-delivery',
                    groupValue: provider.paymentMethod,
                    onChanged: provider.changePaymentMethod,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Pay on Delivery')),
                RadioListTile(
                  value: 'pay-now',
                  groupValue: provider.paymentMethod,
                  onChanged: provider.changePaymentMethod,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Pay Now'),
                ),
              ],
            );
          }),
          const GapWidget(),
          PrimaryButton(
            text: 'Place Order',
            onPressed: () async {
              OrderModel? newOrder = await BlocProvider.of<OrderCubit>(context)
                  .createOrder(
                      items: BlocProvider.of<CartCubit>(context).state.items,
                      paymentMethod: Provider.of<OrderDetailProvider>(context,
                              listen: false)
                          .paymentMethod
                          .toString());

              if (newOrder == null) return;

              if (newOrder.status == 'payment-pending') {
                // Payment
                await RazorpayServices.checkoutOrder(newOrder,
                    onSuccess: (response) async {
                  newOrder.status = 'order-placed';
                  bool success = await BlocProvider.of<OrderCubit>(context)
                      .updateOrder(newOrder,
                          paymentId: response.paymentId,
                          signature: response.signature);

                  if (!success) {
                    log("Can't update the order!");
                  }

                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushNamed(context, OrderPlacedScreen.routeName);
                }, onFailure: (response) {
                  log('Payment Failed!');
                });
              }

              if (newOrder.status == 'order-placed') {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushNamed(context, OrderPlacedScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
