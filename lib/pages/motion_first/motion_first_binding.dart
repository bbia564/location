import 'package:get/get.dart';

import 'motion_first_logic.dart';

class MotionFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MotionFirstLogic());
  }
}
