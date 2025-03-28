import 'package:get/get.dart';
import 'package:motion_record/db_montion/db_motion.dart';
import 'package:motion_record/db_montion/motion_entity.dart';

class MotionFirstLogic extends GetxController {
  DBMotion dbMotion = Get.find();

  var list = <MotionEntity>[].obs;
  var todaySteps = 0;
  var todaySeconds = 0;
  var todayHeat = 0.0;
  var todayDistance = 0.0;

  void getData() async {
    final result = await dbMotion.getMotionAllData();
    list.value = result;
    final now = DateTime.now();
    if (result.isNotEmpty) {
      todaySteps = result
          .where((element) =>
      element.createdTime.year == now.year &&
          element.createdTime.month == now.month &&
          element.createdTime.day == now.day)
          .map((e) => e.stepNumber)
          .reduce((value, element) => value + element);
      todaySeconds = result
          .where((element) =>
      element.createdTime.year == now.year &&
          element.createdTime.month == now.month &&
          element.createdTime.day == now.day)
          .map((e) => e.seconds)
          .reduce((value, element) => value + element);
      todayHeat = result
          .where((element) =>
      element.createdTime.year == now.year &&
          element.createdTime.month == now.month &&
          element.createdTime.day == now.day)
          .map((e) => double.parse(e.heat))
          .reduce((value, element) => value + element);
      todayDistance = result
          .where((element) =>
      element.createdTime.year == now.year &&
          element.createdTime.month == now.month &&
          element.createdTime.day == now.day)
          .map((e) => double.parse(e.distance))
          .reduce((value, element) => value + element);
    } else {
      todaySteps = 0;
      todaySeconds = 0;
      todayHeat = 0.0;
      todayDistance = 0.0;
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
