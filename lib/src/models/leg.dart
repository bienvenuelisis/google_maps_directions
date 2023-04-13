// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'distance_value.dart';
import 'duration_value.dart';
import 'leg_step.dart';
import 'point.dart';

class Leg extends Equatable {
  const Leg({
    required this.distance,
    required this.duration,
    required this.endAddress,
    required this.endLocation,
    required this.startAddress,
    required this.startLocation,
    required this.steps,
    required this.trafficSpeedEntry,
    required this.viaWaypoint,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        distance: DistanceValue.fromJson(json["distance"]),
        duration: DurationValue.fromJson(json["duration"]),
        endAddress: json["end_address"],
        endLocation: Point.fromJson(json["end_location"]),
        startAddress: json["start_address"],
        startLocation: Point.fromJson(json["start_location"]),
        steps:
            List<LegStep>.from(json["steps"].map((x) => LegStep.fromJson(x))),
        trafficSpeedEntry:
            List<dynamic>.from(json["traffic_speed_entry"].map((x) => x)),
        viaWaypoint: List<dynamic>.from(json["via_waypoint"].map((x) => x)),
      );

  final DistanceValue distance;
  final DurationValue duration;
  final String endAddress;
  final Point endLocation;
  final String startAddress;
  final Point startLocation;
  final List<LegStep> steps;
  final List<dynamic> trafficSpeedEntry;
  final List<dynamic> viaWaypoint;

  @override
  List<Object> get props {
    return [
      distance,
      duration,
      endAddress,
      endLocation,
      startAddress,
      startLocation,
      steps,
      trafficSpeedEntry,
      viaWaypoint,
    ];
  }

  @override
  bool get stringify => true;

  int get distanceInMeters => distance.meters;

  Leg copyWith({
    DistanceValue? distance,
    DurationValue? duration,
    String? endAddress,
    Point? endLocation,
    String? startAddress,
    Point? startLocation,
    List<LegStep>? steps,
    List<dynamic>? trafficSpeedEntry,
    List<dynamic>? viaWaypoint,
  }) =>
      Leg(
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
        endAddress: endAddress ?? this.endAddress,
        endLocation: endLocation ?? this.endLocation,
        startAddress: startAddress ?? this.startAddress,
        startLocation: startLocation ?? this.startLocation,
        steps: steps ?? this.steps,
        trafficSpeedEntry: trafficSpeedEntry ?? this.trafficSpeedEntry,
        viaWaypoint: viaWaypoint ?? this.viaWaypoint,
      );

  Map<String, dynamic> toJson() => {
        "distance": distance.toJson(),
        "duration": duration.toJson(),
        "end_address": endAddress,
        "end_location": endLocation.toJson(),
        "start_address": startAddress,
        "start_location": startLocation.toJson(),
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
        "traffic_speed_entry":
            List<dynamic>.from(trafficSpeedEntry.map((x) => x)),
        "via_waypoint": List<dynamic>.from(viaWaypoint.map((x) => x)),
      };
}
