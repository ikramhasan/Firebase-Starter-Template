import 'package:firebase_auth_starter/src/auth/application/user_info/user_info_cubit.dart';
import 'package:firebase_auth_starter/src/auth/presentation/user_info/components/user_info_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UserInfoCubit>().getUserInfo();
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: const UserInfoForm(),
    );
  }
}
