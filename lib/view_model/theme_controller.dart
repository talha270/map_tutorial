import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadThemeFromPreferences();
  }

  // Toggle theme and save the preference
  void toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
    await saveThemeToPreferences(isDarkMode.value);
  }

  // Save theme preference to SharedPreferences
  Future<void> saveThemeToPreferences(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  // Load theme preference from SharedPreferences
  Future<void> loadThemeFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? true;
    Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
  }
}
