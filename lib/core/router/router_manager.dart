import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterManager {
  final List<RouteBase> dataRoute = [];
  static GlobalKey<NavigatorState> keyRoute =
      GlobalKey<NavigatorState>(debugLabel: "primary_route");
  static final RouterManager _instance = RouterManager._internal();
  factory RouterManager({required List<RouteBase> data}) {
    _instance.dataRoute.addAll(data);
    return _instance;
  }
  RouterManager._internal();

  GoRouter routerManager() {
    return GoRouter(
        initialLocation: "/", routes: dataRoute, navigatorKey: keyRoute);
  }
}
