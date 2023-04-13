// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'bounds.dart';
import 'leg.dart';
import 'leg_polyline.dart';

class Route extends Equatable {
  const Route({
    required this.bounds,
    required this.copyrights,
    required this.legs,
    required this.overviewPolyline,
    required this.summary,
    required this.warnings,
    required this.waypointOrder,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        bounds: Bounds.fromJson(json["bounds"]),
        copyrights: json["copyrights"],
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        overviewPolyline: LegPolyline.fromJson(json["overview_polyline"]),
        summary: json["summary"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
        waypointOrder: List<dynamic>.from(json["waypoint_order"].map((x) => x)),
      );

  final Bounds bounds;
  final String copyrights;
  final List<Leg> legs;
  final LegPolyline overviewPolyline;
  final String summary;
  final List<dynamic> warnings;
  final List<dynamic> waypointOrder;

  @override
  List<Object> get props {
    return [
      bounds,
      copyrights,
      legs,
      overviewPolyline,
      summary,
      warnings,
      waypointOrder,
    ];
  }

  @override
  bool get stringify => true;

  Leg get shortestLeg => (legs
        ..sort((l1, l2) => l1.distanceInMeters.compareTo(l2.distanceInMeters)))
      .first;

  Route copyWith({
    Bounds? bounds,
    String? copyrights,
    List<Leg>? legs,
    LegPolyline? overviewPolyline,
    String? summary,
    List<dynamic>? warnings,
    List<dynamic>? waypointOrder,
  }) =>
      Route(
        bounds: bounds ?? this.bounds,
        copyrights: copyrights ?? this.copyrights,
        legs: legs ?? this.legs,
        overviewPolyline: overviewPolyline ?? this.overviewPolyline,
        summary: summary ?? this.summary,
        warnings: warnings ?? this.warnings,
        waypointOrder: waypointOrder ?? this.waypointOrder,
      );

  Map<String, dynamic> toJson() => {
        "bounds": bounds.toJson(),
        "copyrights": copyrights,
        "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
        "overview_polyline": overviewPolyline.toJson(),
        "summary": summary,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
        "waypoint_order": List<dynamic>.from(waypointOrder.map((x) => x)),
      };
}
