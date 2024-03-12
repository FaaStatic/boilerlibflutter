import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static final _permission = PermissionUtil._internal();

  factory PermissionUtil() {
    return _permission;
  }
  PermissionUtil._internal();

  Future<void> permissionLocation() async {
    try {
      await Permission.location.request().then((value) {
        if (value == PermissionStatus.granted) {
          print("Permission granted");
        } else {
          print("Permission not granted");
        }
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> permissionStorage() async {
    try {
      if (Platform.isAndroid) {
        if (int.parse(Platform.operatingSystemVersion) > 32) {
          await Permission.photos.request().then((value) {
            if (value == PermissionStatus.granted) {
              print("Permission granted");
            } else {
              print("Permission not granted");
            }
          });
        } else {
          await Permission.storage.request().then((value) {
            if (value == PermissionStatus.granted) {
              print("Permission granted");
            } else {
              print("Permission not granted");
            }
          });
        }
      } else {
        await Permission.photos.request().then((value) {
          if (value == PermissionStatus.granted) {
            print("Permission granted");
          } else {
            print("Permission not granted");
          }
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> permissionCamera() async {
    try {
      await Permission.camera.request().then((value) {
        if (value == PermissionStatus.granted) {
          print("Permission granted");
        } else {
          print("Permission not granted");
        }
      });
    } catch (error) {
      print(error);
    }
  }
}
