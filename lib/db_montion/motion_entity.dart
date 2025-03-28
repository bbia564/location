import 'package:intl/intl.dart';

class MotionEntity {
  int id;
  DateTime createdTime;
  int stepNumber;
  int seconds;
  String heat;
  String distance;

  MotionEntity({
    required this.id,
    required this.createdTime,
    required this.stepNumber,
    required this.seconds,
    required this.heat,
    required this.distance,
  });

  factory MotionEntity.fromJson(Map<String, dynamic> json) {
    return MotionEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      stepNumber: json['stepNumber'],
      seconds: json['seconds'],
      heat: json['heat'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'stepNumber': stepNumber,
      'seconds': seconds,
      'heat': heat,
      'distance': distance,
    };
  }

  String get  createdTimeStr => DateFormat('yyyy/MM/dd').format(createdTime);
}