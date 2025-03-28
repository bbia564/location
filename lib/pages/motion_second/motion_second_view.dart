import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'motion_second_logic.dart';

class MotionSecondPage extends GetView<MotionSecondLogic> {
  const MotionSecondPage({super.key});

  Widget _item(int index, BuildContext context) {
    final titles = ['Complete motion record', 'Clean all records', 'About us'];
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: <Widget>[
        Text(titles[index]),
        index == 2
            ? const Text("1.0.0")
            : const Icon(
                Icons.keyboard_arrow_right,
                size: 20,
                color: Colors.grey,
              )
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    )
        .decorated(
            color: const Color(0xfff4f6fa),
            borderRadius: BorderRadius.circular(12))
        .marginOnly(bottom: 10)
        .gestures(onTap: () {
      switch (index) {
        case 0:
          Get.toNamed('/motionRecords');
          break;
        case 1:
          controller.cleanMotionData();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: <Widget>[
                      _item(0, context),
                      _item(1, context),
                      _item(2, context)
                    ].toColumn())
                .marginAll(15)),
      ),
    );
  }
}
