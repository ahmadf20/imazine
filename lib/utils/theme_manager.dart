import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum GlobalTheme { dark, light }

GlobalTheme globalTheme = GlobalTheme.light;

void setTheme(GlobalTheme theme) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  applyTheme(theme);
  await preferences.setString(
      'theme', theme == GlobalTheme.dark ? 'dark' : 'light');
}

void getTheme() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  GlobalTheme theme = (await preferences.getString('theme') == 'dark'
      ? GlobalTheme.dark
      : GlobalTheme.light);
  applyTheme(theme);
}

void applyTheme(GlobalTheme theme) {
  Get.changeThemeMode(
      theme == GlobalTheme.dark ? ThemeMode.dark : ThemeMode.light);
  globalTheme = theme;
}
