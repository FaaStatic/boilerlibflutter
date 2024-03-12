library boilerlib;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

export 'package:boilerlib/boilerlib.dart';
export 'core/api/api_manager.dart';
export 'core/camera/camera_widget.dart';
export 'core/permission_util/permission_util.dart';
export 'core/router/router_manager.dart';
export 'core/storage_util/storage_util.dart';

class Boilerlib {
  static final Boilerlib _main = Boilerlib._internal();

  factory Boilerlib() {
    return _main;
  }

  Boilerlib._internal();

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
}
