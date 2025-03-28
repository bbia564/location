import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_record/db_montion/db_motion.dart';
import 'package:motion_record/pages/motion_add/motion_add_binding.dart';
import 'package:motion_record/pages/motion_add/motion_add_view.dart';
import 'package:motion_record/pages/motion_first/motion_first_binding.dart';
import 'package:motion_record/pages/motion_first/motion_first_view.dart';
import 'package:motion_record/pages/motion_records/motion_records_binding.dart';
import 'package:motion_record/pages/motion_records/motion_records_view.dart';
import 'package:motion_record/pages/motion_second/motion_second_binding.dart';
import 'package:motion_record/pages/motion_second/motion_second_view.dart';
import 'package:motion_record/pages/motion_start/motion_start_binding.dart';
import 'package:motion_record/pages/motion_start/motion_start_view.dart';
import 'package:motion_record/pages/motion_tab/motion_tab_binding.dart';
import 'package:motion_record/pages/motion_tab/motion_tab_view.dart';
import 'package:motion_record/pages/no_network/no_network_binding.dart';
import 'package:motion_record/pages/no_network/no_network_view.dart';

import 'db_montion/motion_methods.dart';

Color primaryColor = const Color(0xff0062ff);
Color bgColor = Colors.white;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBMotion().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Locations,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Locations = [
  GetPage(
    name: '/',
    page: () => const MotionStartView(),
    binding: MotionStartBinding(),
  ),
  GetPage(
    name: '/motionTab',
    page: () => MotionTabPage(),
    binding: MotionTabBinding(),
  ),
  GetPage(
    name: '/motionFirst',
    page: () => MotionFirstPage(),
    binding: MotionFirstBinding(),
  ),
  GetPage(
    name: '/motionStart',
    page: () => const MotionMethods(),
  ),
  GetPage(
    name: '/motionSecond',
    page: () => const MotionSecondPage(),
    binding: MotionSecondBinding(),
  ),
  GetPage(
    name: '/motionAdd',
    page: () => const MotionAddPage(),
    binding: MotionAddBinding(),
  ),
  GetPage(
    name: '/motionRecords',
    page: () => MotionRecordsPage(),
    binding: MotionRecordsBinding(),
  ),
  GetPage(
    name: '/refresh',
    page: () => NoNetworkPage(),
    binding: NoNetworkBinding(),
  ),
];