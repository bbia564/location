import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_record/pages/motion_add/motion_add_view.dart';
import 'package:motion_record/pages/motion_first/motion_first_logic.dart';
import 'package:motion_record/pages/motion_first/motion_first_view.dart';
import 'package:motion_record/pages/motion_second/motion_second_view.dart';

import '../../main.dart';
import 'motion_tab_logic.dart';

class MotionTabPage extends GetView<MotionTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          MotionFirstPage(),
          const MotionAddPage(),
          MotionSecondPage()
        ],
      ),
      bottomNavigationBar: Obx(()=>_navMoBars()),
    );
  }

  Widget _navMoBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled,color: Colors.grey.withOpacity(0.6)),
          activeIcon:Icon(Icons.home_filled,color: primaryColor),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle,color: primaryColor,size: 40,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings,color: Colors.grey.withOpacity(0.6)),
          activeIcon:Icon(Icons.settings,color: primaryColor),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        if (index == 1) {
          Get.toNamed('/motionAdd')?.then((_) {
            MotionFirstLogic firstLogic = Get.put(MotionFirstLogic());
            firstLogic.getData();
          });
        } else {
          controller.currentIndex.value = index;
          controller.pageController.jumpToPage(index);
        }
      },
    );
  }
}
