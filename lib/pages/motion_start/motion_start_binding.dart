import 'package:get/get.dart';

import 'motion_start_logic.dart';

class MotionStartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
