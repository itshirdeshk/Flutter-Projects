import 'package:ecommerce_frontend/core/ui.dart';
import 'package:ecommerce_frontend/data/models/user/user_model.dart';
import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce_frontend/presentation/widgets/gap_widget.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_button.dart';
import 'package:ecommerce_frontend/presentation/widgets/primary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const String routeName = 'edit_profile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is UserLogggedInState) {
          return editProfile(state.userModel);
        }

        return const Center(
          child: Text('An Error Occured'),
        );
      }),
    );
  }

  Widget editProfile(UserModel userModel) {
    return ListView(
      children: [
        Text(
          'Personal Details',
          style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),
        ),
        const GapWidget(
          size: -10,
        ),
        PrimaryTextField(
          labelText: 'Full Name',
          initialValue: userModel.fullName,
          onChange: (value) {
            userModel.fullName = value;
          },
        ),
        const GapWidget(
          size: 20,
        ),
        Text(
          'Address',
          style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),
        ),
        PrimaryTextField(
          labelText: 'Address',
          initialValue: userModel.address,
          onChange: (value) {
            userModel.address = value;
          },
        ),
        const GapWidget(),
        PrimaryTextField(
          labelText: 'City',
          initialValue: userModel.city,
          onChange: (value) {
            userModel.city = value;
          },
        ),
        const GapWidget(),
        PrimaryTextField(
          labelText: 'State',
          initialValue: userModel.state,
          onChange: (value) {
            userModel.state = value;
          },
        ),
        const GapWidget(),
        PrimaryButton(
          text: 'Save',
          onPressed: () async {
            bool success =
                await BlocProvider.of<UserCubit>(context).updateUser(userModel);

            if (success) {
              Navigator.pop(context);
            }
          },
        )
      ],
    );
  }
}
