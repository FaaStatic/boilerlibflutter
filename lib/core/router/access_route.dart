import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccessRoute {
  static final AccessRoute _main = AccessRoute._internal();

  factory AccessRoute() {
    return _main;
  }

  AccessRoute._internal();

  final List<RouteBase> data = [];

  void addScreen(String path, Widget screen) {
    data.add(GoRoute(
      path: path,
      builder: (context, state) {
        return screen;
      },
    ));
  }

  void addScreenAll(List<Map<String, dynamic>> dataList) {
    for (var item in dataList) {
      data.add(GoRoute(
        path: item["path"],
        builder: (context, state) {
          return item["screen"];
        },
      ));
    }
  }

  void replacePage(BuildContext context, String path) {
    context.go(path);
  }

  void pushPage(BuildContext context, String path) {
    context.push(path);
  }

  void backPage(BuildContext context, dynamic value) {
    context.pop(value);
  }
}
