import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import 'motion_records_logic.dart';

class MotionRecordsPage extends GetView<MotionRecordsLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f6fa),
      appBar: AppBar(title: const Text('Complete motion record')),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(child: Obx(() {
          return controller.list.value.isEmpty
              ? const Center(
                  child: Text('No data'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(15),
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
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                entity.createdTimeStr,
                                style: const TextStyle(color: Colors.grey),
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
                                  DateTime(0)
                                      .add(Duration(seconds: entity.seconds)),
                                ),
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Minutes',
                                style: TextStyle(color: Colors.grey),
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
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Kcal',
                                style: TextStyle(color: Colors.grey),
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
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Km',
                                style: TextStyle(color: Colors.grey),
                              )
                            ].toColumn())
                      ].toRow(),
                    )
                        .decorated(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12))
                        .marginOnly(bottom: 10);
                  });
        })),
      ),
    );
  }
}
