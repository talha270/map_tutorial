import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:map_tutorial/view/cordinates_to_address.dart';
import 'package:map_tutorial/view/showmap.dart';
import 'package:map_tutorial/view_model/theme_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoMaps Example',
      theme: themeController.isDarkMode.value ? ThemeData.dark() : ThemeData.light(),

      home:
      // CoordinatesAddressConverter(),
      GoMapsPage(),
    );
  }
}