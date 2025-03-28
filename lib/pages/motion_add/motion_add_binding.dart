import 'package:get/get.dart';

import 'motion_add_logic.dart';

class MotionAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MotionAddLogic());
  }
}
