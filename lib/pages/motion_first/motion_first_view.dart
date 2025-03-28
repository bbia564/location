import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motion_record/main.dart';
import 'package:styled_widget/styled_widget.dart';

import 'gradient_arc.dart';
import 'motion_first_logic.dart';

class MotionFirstPage extends GetView<MotionFirstLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<MotionFirstLogic>(
                init: MotionFirstLogic(),
                builder: (_) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: <Widget>[
                      const Text('Today'),
                      SizedBox(
                        width: 245,
                        height: 245,
                        child: <Widget>[
                          ArcProgress(
                              size: 245,
                              progress:
                                  controller.todaySteps.toDouble() / 8000),
                          Positioned(
                              width: 245,
                              top: 50,
                              child: <Widget>[
                                Text(
                                  controller.todaySteps.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 51),
                                ),
                                const Text(
                                  'Steps',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 20),
                                ),
                              ].toColumn(
                                  mainAxisAlignment: MainAxisAlignment.end)),
                          Positioned(
                              width: 245,
                              bottom: 0,
                              child: <Widget>[
                                const Text(
                                  'Target',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const Text(
                                  '8000',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23),
                                )
                              ].toColumn(
                                  mainAxisAlignment: MainAxisAlignment.end))
                        ].toStack(),
                      ).marginSymmetric(vertical: 15),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: <Widget>[
                          <Widget>[
                            Expanded(
                                child: <Widget>[
                              Image.asset(
                                'assets/icon0.webp',
                                width: 23,
                                height: 23,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                DateFormat('mm:ss').format(
                                  DateTime(0).add(Duration(
                                      seconds: controller.todaySeconds)),
                                ),
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'Minutes',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6)),
                              )
                            ].toColumn(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center)),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: <Widget>[
                              Image.asset(
                                'assets/icon1.webp',
                                width: 22,
                                height: 27,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                controller.todayHeat.toStringAsFixed(1),
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'Kcal',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6)),
                              )
                            ].toColumn(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center)),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: <Widget>[
                              Image.asset(
                                'assets/icon2.webp',
                                width: 27,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                controller.todayDistance.toStringAsFixed(1),
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'Km',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6)),
                              )
                            ].toColumn(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center)),
                          ].toRow(),
                        ].toColumn(),
                      ).decorated(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Motion record',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(() {
                        return controller.list.value.isEmpty
                            ? const Center(
                                child: Text('No data'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.list.value.length,
                                itemBuilder: (_, index) {
                                  final entity = controller.list.value[index];
                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    child: <Widget>[
                                      Expanded(
                                          flex: 3,
                                          child: <Widget>[
                                            Text(
                                              entity.stepNumber.toString(),
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              entity.createdTimeStr,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            )
                                          ].toColumn()),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: <Widget>[
                                            Text(
                                              DateFormat('mm:ss').format(
                                                DateTime(0).add(Duration(
                                                    seconds: entity.seconds)),
                                              ),
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              'Minutes',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ].toColumn()),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: <Widget>[
                                            Text(
                                              entity.heat,
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              'Kcal',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ].toColumn()),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: <Widget>[
                                            Text(
                                              entity.distance,
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              'Km',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ].toColumn())
                                    ].toRow(),
                                  )
                                      .decorated(
                                          color: const Color(0xfff4f6fa),
                                          borderRadius:
                                              BorderRadius.circular(12))
                                      .marginOnly(bottom: 10);
                                });
                      })
                    ].toColumn(),
                  );
                }).marginAll(15)),
      ),
    );
  }
}
