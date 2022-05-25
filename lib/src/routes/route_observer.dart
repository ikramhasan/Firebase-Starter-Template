import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class RouteObserver extends AutoRouterObserver {
  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log('Replaced old route: ${oldRoute?.settings.name} with new route: ${newRoute?.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    log('Popped route: ${route.settings.name} from route: ${previousRoute?.settings.name}');
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    log('New route pushed: ${route.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log('Tab route re-visited: ${route.name}');
  }
}
