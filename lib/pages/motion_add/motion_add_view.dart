import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_record/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:styled_widget/styled_widget.dart';
import '../../db_montion/motion_entity.dart';
import 'motion_add_logic.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';

class MotionAddPage extends StatefulWidget {
  const MotionAddPage({Key? key}) : super(key: key);

  @override
  State<MotionAddPage> createState() => _MotionAddPageState();
}

class _MotionAddPageState extends State<MotionAddPage> {
  MotionAddLogic controller = Get.find();

  final double kcalPerKm = 1.036;
  double weight = 70;

  bool isRunning = false;
  int seconds = 0;
  double distance = 0;
  List<LatLng> pathPoints = [];
  late StreamSubscription<Position> positionStream;
  late MapController mapController;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _requestLocationPermission();
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Location permissions required'),
        content:
            const Text('Please grant location permission to measure speed'),
        actions: [
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text('Setting'),
          ),
        ],
      ),
    );
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      _startRun();
    } else {
      _showPermissionDialog();
    }
  }

  void _startRun() {
    setState(() {
      isRunning = true;
      seconds = 0;
      distance = 0;
      pathPoints.clear();
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => seconds++);
    });

    positionStream = Geolocator.getPositionStream(
      locationSettings:const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      final newPoint = LatLng(position.latitude, position.longitude);

      setState(() {
        if (pathPoints.isNotEmpty) {
          final lastPoint = pathPoints.last;
          distance +=
              const Distance().as(LengthUnit.Meter, lastPoint, newPoint);
        }

        pathPoints.add(newPoint);
        mapController.move(newPoint, mapController.camera.zoom);
      });
    });
  }

  void _stopRun() async {
    timer?.cancel();
    positionStream.cancel();
    setState(() => isRunning = false);
    await controller.dbMotion.insertMotion(MotionEntity(
      id: 0,
      createdTime: DateTime.now(),
      stepNumber: (distance~/2),
      seconds: seconds,
      heat: calories.toStringAsFixed(1),
      distance: distance.toString(),
    ));
  }

  double get calories => (distance / 1000) * weight * kcalPerKm;

  @override
  void dispose() {
    timer?.cancel();
    positionStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f6fa),
      appBar: AppBar(title: const Text('New movement')),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                height: 413,
                child: _buildMap(),
              ).decorated(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
            ),
            <Widget>[
              Text(
                (distance / 1000).toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 51,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'km',
                style: TextStyle(fontSize: 16, color: primaryColor),
              )
            ].toRow(mainAxisAlignment: MainAxisAlignment.center),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: <Widget>[
                <Widget>[
                  Expanded(
                      child: <Widget>[
                    Text(
                      DateFormat('mm:ss').format(
                        DateTime(0).add(Duration(seconds: seconds)),
                      ),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text('Minutes')
                  ].toColumn(crossAxisAlignment: CrossAxisAlignment.center)),
                  const SizedBox(width: 5,),
                  Expanded(
                      child: <Widget>[
                        Text(
                          (distance~/2).toString(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Text('Steps')
                      ].toColumn(crossAxisAlignment: CrossAxisAlignment.center)),
                  const SizedBox(width: 5,),
                  Expanded(
                      child: <Widget>[
                        Text(
                          calories.toStringAsFixed(1),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Text('Kcal')
                      ].toColumn(crossAxisAlignment: CrossAxisAlignment.center))
                ].toRow(),
                const SizedBox(height: 15,),
                Container(
                  width: double.infinity,
                  height: 44,
                  alignment: Alignment.center,
                  child: Text(isRunning ? 'Stop/SaveStart' : 'Start',
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                )
                    .decorated(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12))
                    .gestures(
                        onTap:
                            isRunning ? _stopRun : _requestLocationPermission)
              ].toColumn(),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(20))
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: mapController,
      options: const MapOptions(
        initialCenter: LatLng(0, 0),
        initialZoom: 15,
        interactionOptions: InteractionOptions(
          flags: InteractiveFlag.all,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.example.run_tracker',
          retinaMode: true,
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: pathPoints,
              color: Colors.blue,
              strokeWidth: 4,
            ),
          ],
        ),
        MarkerLayer(
          markers: pathPoints.isNotEmpty
              ? [
                  Marker(
                    point: pathPoints.last,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_pin,
                        color: Colors.red, size: 40),
                  )
                ]
              : [],
        ),
      ],
    );
  }
}
