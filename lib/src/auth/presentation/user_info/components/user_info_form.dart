import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth_starter/src/auth/application/auth_bloc.dart';
import 'package:firebase_auth_starter/src/auth/application/user_info/user_info_cubit.dart';
import 'package:firebase_auth_starter/src/core/application/file_uploader/file_uploader_cubit.dart';
import 'package:firebase_auth_starter/src/core/domain/entities/failure.dart';
import 'package:firebase_auth_starter/src/core/presentation/components/show_error.dart';
import 'package:firebase_auth_starter/src/core/presentation/spacing.dart';
import 'package:firebase_auth_starter/src/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoForm extends StatelessWidget {
  const UserInfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfoBloc = context.read<UserInfoCubit>();
    final fileUploaderBloc = context.read<FileUploaderCubit>();
    final userId = context
        .read<AuthBloc>()
        .state
        .whenOrNull(authenticated: (user) => user.id.getOrCrash());

    return MultiBlocListener(
      listeners: [
        BlocListener<FileUploaderCubit, FileUploaderState>(
          listener: (context, state) {
            if (state.uploaded) {
              userInfoBloc.setImageUrl(state.downloadUrl);
            } else if (state.failure != Failure.none()) {
              showError(context: context, message: state.failure.message);
            }
          },
        ),
        BlocListener<UserInfoCubit, UserInfoState>(
          listener: (context, state) {
            if (state.user.name!.isNotEmpty) {
              AutoRouter.of(context).replace(const HomeRoute());
            } else if (state.failure != Failure.none()) {
              showError(context: context, message: state.failure.message);
            }
          },
        ),
      ],
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              autovalidateMode: state.showErrorMessages
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Column(
                children: [
                  BlocBuilder<FileUploaderCubit, FileUploaderState>(
                    builder: (context, state) {
                      if (state.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.uploaded) {
                        return Image.network(
                          state.downloadUrl,
                          height: 200,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  verticalSpace8,
                  ElevatedButton(
                    onPressed: () {
                      fileUploaderBloc.uploadImage('users/$userId');
                    },
                    child: const Text('Choose Image'),
                  ),
                  verticalSpace8,
                  TextFormField(
                    autocorrect: false,
                    decoration: const InputDecoration(labelText: 'Name'),
                    onChanged: (value) {
                      userInfoBloc.nameChanged(value);
                    },
                    validator: (_) {
                      if (userInfoBloc.state.name.isEmpty) {
                        return 'Name cannot be empty';
                      } else if (RegExp(r'[!@#<>?":_`~;[\]\|=+)(*&^%0-9-]')
                          .hasMatch(userInfoBloc.state.name)) {
                        return 'Name cannot contain numbers';
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      userInfoBloc.setUserInfo();
                    },
                    child: const Text('Continue'),
                  ),
                  verticalSpace16,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
