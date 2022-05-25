import 'package:firebase_auth_starter/src/auth/application/auth_bloc.dart';
import 'package:firebase_auth_starter/src/auth/application/sign_in_form/sign_in_form_bloc.dart';
import 'package:firebase_auth_starter/src/core/presentation/components/show_error.dart';
import 'package:firebase_auth_starter/src/core/presentation/spacing.dart';
import 'package:firebase_auth_starter/src/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showErrorMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              if (state.isSubmitting) ...[const LinearProgressIndicator()],
              verticalSpace8,
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  hintText: 'e.g ikramhasan.dev@gmail.com',
                ),
                autocorrect: false,
                onChanged: (value) => context
                    .read<SignInFormBloc>()
                    .add(SignInFormEvent.emailChanged(value)),
                validator: (_) => context
                    .read<SignInFormBloc>()
                    .state
                    .emailAddress
                    .value
                    .fold(
                      (f) => f.maybeMap(
                        invalidEmail: (_) => 'Email is not valid',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              verticalSpace8,
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => context
                    .read<SignInFormBloc>()
                    .add(SignInFormEvent.passwordChanged(value)),
                validator: (_) => context
                    .read<SignInFormBloc>()
                    .state //
                    .password //
                    .value //
                    .fold(
                      (f) => f.maybeMap(
                        shortPassword: (_) => 'Password is too short',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              verticalSpace8,
              ElevatedButton(
                onPressed: () {
                  context.read<SignInFormBloc>().add(
                        const SignInFormEvent
                            .signInWithEmailAndPasswordPressed(),
                      );
                },
                child: const Text('SIGN IN'),
              ),
              verticalSpace8,
              ElevatedButton(
                onPressed: () {
                  context.read<SignInFormBloc>().add(
                        const SignInFormEvent
                            .registerWithEmailAndPasswordPressed(),
                      );
                },
                child: const Text('REGISTER'),
              ),
              verticalSpace8,
              ElevatedButton(
                onPressed: () {
                  context
                      .read<SignInFormBloc>()
                      .add(const SignInFormEvent.signInWithGooglePressed());
                },
                child: const Text('SIGN IN WITH GOOGLE'),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () => null,
          (either) => either.fold(
            (failure) {
              showError(
                context: context,
                message: failure.map(
                  cancelledByUser: (_) => 'Process cancelled by user',
                  serverError: (_) => 'Server error!',
                  emailAlreadyInUse: (_) => 'Email already in use!',
                  invalidEmailAndPasswordCombination: (_) =>
                      'Invalid email and password combination',
                ),
              );
            },
            (success) {
              context.router.replace(const UserInfoRoute());
              context
                  .read<AuthBloc>()
                  .add(const AuthEvent.authCheckRequested());
            },
          ),
        );
      },
    );
  }
}
