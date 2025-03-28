import 'package:get/get.dart';

import '../motion_first/motion_first_logic.dart';
import '../motion_second/motion_second_logic.dart';
import 'motion_tab_logic.dart';

class MotionTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MotionTabLogic());
    Get.lazyPut(() => MotionFirstLogic());
    Get.lazyPut(() => MotionSecondLogic());
  }
}
