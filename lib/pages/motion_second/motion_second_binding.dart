import 'package:get/get.dart';

import 'motion_second_logic.dart';

class MotionSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MotionSecondLogic());
  }
}
