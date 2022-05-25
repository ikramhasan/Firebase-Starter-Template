import 'package:auto_route/annotations.dart';
import 'package:firebase_auth_starter/src/auth/presentation/sign_in/sign_in_page.dart';
import 'package:firebase_auth_starter/src/auth/presentation/user_info/user_info_page.dart';
import 'package:firebase_auth_starter/src/home/presentation/home_page.dart';
import 'package:firebase_auth_starter/src/splash/presentation/splash_page.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: SignInPage),
    MaterialRoute(page: HomePage),
    MaterialRoute(page: UserInfoPage),
  ],
)
class $AppRouter {}
