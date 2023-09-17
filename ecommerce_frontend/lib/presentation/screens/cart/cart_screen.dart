import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_frontend/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce_frontend/logic/services/calculations.dart';
import 'package:ecommerce_frontend/logic/services/formatter.dart';
import 'package:ecommerce_frontend/presentation/screens/order/order_detail_screen.dart';
import 'package:ecommerce_frontend/presentation/widgets/cart_listview_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String routeName = 'cart_screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart'),
      ),
      body: SafeArea(child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLodingState && state.items.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CartErrorState && state.items.isEmpty) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is CartLoadedState && state.items.isEmpty) {
            return const Center(
              child: Text("Cart items will show up here..."),
            );
          }
          return Column(
            children: [
              Expanded(child: CartListView(items: state.items)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            "${state.items.length} items",
                            style: TextStyles.body1
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Total : ${Formatter.formatPrice(Calculations.cartTotal(state.items))}',
                            style: TextStyles.heading3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: CupertinoButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, OrderDetailScreen.routeName);
                        },
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 22),
                        color: AppColors.accent,
                        child: const Text('Place Order'),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      )),
    );
  }
}
