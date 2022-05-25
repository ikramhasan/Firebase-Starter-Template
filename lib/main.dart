import 'dart:async';

import 'package:firebase_auth_starter/src/core/application/app_bloc_observer.dart';
import 'package:firebase_auth_starter/src/core/presentation/app.dart';
import 'package:firebase_auth_starter/src/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.prod);
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
    () {
      runApp(App());
    },
    blocObserver: AppBlocObserver(),
  );
}
