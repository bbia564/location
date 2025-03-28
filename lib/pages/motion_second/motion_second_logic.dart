import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_record/db_montion/db_motion.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../motion_first/motion_first_logic.dart';

class MotionSecondLogic extends GetxController {

  DBMotion dbMotion = Get.find();

  cleanMotionData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbMotion.cleanMotionData();
            MotionFirstLogic firstLogic = Get.put(MotionFirstLogic());
            firstLogic.getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutMotionUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 76,
        height: 76,
      ),
      children: [
        const Text(
            """We can record your running time, step count, etc"""),
      ],
      context: context,
    );
  }

}
