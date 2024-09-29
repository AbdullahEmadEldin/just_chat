import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheHelper {
  static late SharedPreferences _instance;
  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");

    if (value is String) return await _instance.setString(key, value);
    if (value is int) return await _instance.setInt(key, value);
    if (value is bool) return await _instance.setBool(key, value);
    return await _instance.setDouble(key, value);
  }

  static dynamic getData({required String key}) {
    debugPrint("SharedPrefHelper : getData with key : $key and value : ${_instance.get(key)}");

    return _instance.get(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await _instance.remove(key);
  }

  static Future<bool> clearData() async {
    return await _instance.clear();
  }

  static Future<bool> containsKey({
    required String key,
  }) async {
    return _instance.containsKey(key);
  }
    /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static setSecuredString({required String key,required String value}) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint(
        "FlutterSecureStorage : setSecuredString with key : $key and value : $value");
    await flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static getSecuredString(String key) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint('FlutterSecureStorage : getSecuredString with key :');
    return await flutterSecureStorage.read(key: key) ?? '';
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }
}
