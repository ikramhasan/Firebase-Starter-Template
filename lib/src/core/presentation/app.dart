import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth_starter/src/auth/application/auth_bloc.dart';
import 'package:firebase_auth_starter/src/auth/application/user_info/user_info_cubit.dart';
import 'package:firebase_auth_starter/src/core/application/file_uploader/file_uploader_cubit.dart';
import 'package:firebase_auth_starter/src/injection.dart';
import 'package:firebase_auth_starter/src/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _appRouter = AppRouter();
  final _observer = RouteObserver();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        ),
        BlocProvider<FileUploaderCubit>(
          create: (context) => getIt<FileUploaderCubit>(),
        ),
        BlocProvider<UserInfoCubit>(
          create: (context) => getIt<UserInfoCubit>(),
        )
      ],
      child: MaterialApp.router(
        routerDelegate: AutoRouterDelegate(
          _appRouter,
          navigatorObservers: () => [_observer],
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: 'Firebase Auth Starter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
