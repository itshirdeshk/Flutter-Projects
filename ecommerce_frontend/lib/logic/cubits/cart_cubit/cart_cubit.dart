import 'dart:async';

import 'package:ecommerce_frontend/data/models/cart/cart_item_model.dart';
import 'package:ecommerce_frontend/data/models/product/product_model.dart';
import 'package:ecommerce_frontend/data/repositories/cart_repository.dart';
import 'package:ecommerce_frontend/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final UserCubit _userCubit;
  StreamSubscription? _userSubscription;
  CartCubit(this._userCubit) : super(CartInitialState()) {
    _handleUserState(_userCubit.state);
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState) {
    if (userState is UserLogggedInState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserLoggedOutState) {
      emit(CartInitialState());
    }
  }

  final _cartRespository = CartRepository();

  void sortAndLoad(List<CartItemModel> items) {
    items.sort((a, b) => b.product!.title!.compareTo(a.product!.title!));
    emit(CartLoadedState(items));
  }

  void _initialize(String userId) async {
    emit(CartLodingState(state.items));
    try {
      final items = await _cartRespository.fetchCartForUser(userId);
      sortAndLoad(items);
    } catch (e) {
      emit(CartErrorState(state.items, e.toString()));
    }
  }

  void addToCart(ProductModel productModel, int quantity) async {
    emit(CartLodingState(state.items));
    try {
      if (_userCubit.state is UserLogggedInState) {
        UserLogggedInState userState = _userCubit.state as UserLogggedInState;
        CartItemModel newItem =
            CartItemModel(product: productModel, quantity: quantity);
        final items =
            await _cartRespository.addToCart(userState.userModel.sId!, newItem);
        sortAndLoad(items);
      } else {
        throw "An error occured while adding the items";
      }
    } catch (e) {
      emit(CartErrorState(state.items, e.toString()));
    }
  }

  void removeFromCart(ProductModel productModel) async {
    emit(CartLodingState(state.items));
    try {
      if (_userCubit.state is UserLogggedInState) {
        UserLogggedInState userState = _userCubit.state as UserLogggedInState;

        final items = await _cartRespository.removeFromCart(
            userState.userModel.sId!, productModel.sId!);
        sortAndLoad(items);
      } else {
        throw "An error occured while removing the items";
      }
    } catch (e) {
      emit(CartErrorState(state.items, e.toString()));
    }
  }

  bool cartContains(ProductModel product) {
    if (state.items.isNotEmpty) {
      final foundItem = state.items
          .where((item) => item.product!.sId == product.sId)
          .toList();

      if (foundItem.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  void clearCart() {
    emit(CartLoadedState([]));
  }

  @override
  Future<void> close() {
    _userSubscription!.cancel();
    return super.close();
  }
}
