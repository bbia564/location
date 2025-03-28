import 'package:get/get.dart';

import 'motion_records_logic.dart';

class MotionRecordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MotionRecordsLogic());
  }
}
