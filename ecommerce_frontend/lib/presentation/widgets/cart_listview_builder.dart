import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_frontend/data/models/cart/cart_item_model.dart';
import 'package:ecommerce_frontend/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_frontend/logic/services/formatter.dart';
import 'package:ecommerce_frontend/presentation/widgets/link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

class CartListView extends StatelessWidget {
  final List<CartItemModel> items;
  final bool shrinkWrap;
  final bool noScroll;
  const CartListView(
      {super.key,
      required this.items,
      this.shrinkWrap = false,
      this.noScroll = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      physics: (noScroll) ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: CachedNetworkImage(
            width: 50,
            imageUrl: item.product!.images![0]),
          title: Text("${item.product!.title}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${Formatter.formatPrice(item.product!.price!)} X ${item.quantity} = ${Formatter.formatPrice(item.product!.price! * item.quantity!)}"),
              LinkButton(
                text: "Delete",
                color: Colors.red,
                onPressed: () {
                  BlocProvider.of<CartCubit>(context)
                      .removeFromCart(item.product!);
                },
              )
            ],
          ),
          trailing: InputQty(
            minVal: 1,
            maxVal: 0,
            showMessageLimit: false,
            initVal: item.quantity!,
            onQtyChanged: (value) {
              if (value == item.quantity) {
                return;
              }
              BlocProvider.of<CartCubit>(context)
                  .addToCart(item.product!, value as int);
            },
          ),
        );
      },
    );
  }
}
