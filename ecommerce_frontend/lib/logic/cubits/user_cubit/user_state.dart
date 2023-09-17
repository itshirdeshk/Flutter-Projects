import 'package:ecommerce_frontend/data/models/user/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLogggedInState extends UserState {
  final UserModel userModel;

  UserLogggedInState(this.userModel);

}

class UserLoggedOutState extends UserState {}

class UserErrorState extends UserState {
  final String message;

  UserErrorState(this.message);

}
