import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static final _storage = StorageUtil._internal();

  factory StorageUtil() {
    return _storage;
  }
  StorageUtil._internal();

  Future<SharedPreferences> init() async {
    final data = await SharedPreferences.getInstance();
    return data;
  }

  Future<void> setAsString(String key, String data) async {
    final storage = await init();
    await storage.setString(key, data);
  }

  Future<void> setAsBool(String key, bool data) async {
    final storage = await init();
    await storage.setBool(key, data);
  }

  Future<String?> getAsString(String key) async {
    final storage = await init();
    String? data = storage.getString(key);
    return data;
  }

  Future<bool?> getAsBool(String key) async {
    final storage = await init();
    bool? data = storage.getBool(key);
    return data;
  }

  Future<Map<String, dynamic>?> getAsMap(String key) async {
    final storage = await init();
    String? data = storage.getString(key);
    if (data != null) {
      return json.decode(data);
    } else {
      return null;
    }
  }

  Future<bool> clearAll(String key) async {
    final storage = await init();
    final status = await storage.clear();
    return status;
  }
}
