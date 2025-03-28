import 'package:get/get.dart';

import '../../db_montion/db_motion.dart';
import '../../db_montion/motion_entity.dart';

class MotionRecordsLogic extends GetxController {

  DBMotion dbMotion = Get.find();

  var list = <MotionEntity>[].obs;

  void getData() async {
    list.value = await dbMotion.getMotionAllData();
  }


  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
