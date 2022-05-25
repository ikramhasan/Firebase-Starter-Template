import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth_starter/src/auth/application/auth_bloc.dart';
import 'package:firebase_auth_starter/src/auth/application/user_info/user_info_cubit.dart';
import 'package:firebase_auth_starter/src/core/application/file_uploader/file_uploader_cubit.dart';
import 'package:firebase_auth_starter/src/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.mapOrNull(
          unauthenticated: (_) => context.router.replace(const SignInRoute()),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
                context.read<UserInfoCubit>().flush();
                context.read<FileUploaderCubit>().flush();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
