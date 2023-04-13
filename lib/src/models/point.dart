// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Point extends Equatable {
  const Point({
    required this.lat,
    required this.lng,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  final double lat;
  final double lng;

  @override
  List<Object> get props => [lat, lng];

  @override
  bool get stringify => true;

  Point copyWith({
    double? lat,
    double? lng,
  }) =>
      Point(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
