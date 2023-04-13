// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'point.dart';

class Bounds extends Equatable {
  const Bounds({
    required this.northeast,
    required this.southwest,
  });

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
        northeast: Point.fromJson(json["northeast"]),
        southwest: Point.fromJson(json["southwest"]),
      );

  final Point northeast;
  final Point southwest;

  @override
  List<Object> get props => [northeast, southwest];

  @override
  bool get stringify => true;

  Bounds copyWith({
    Point? northeast,
    Point? southwest,
  }) {
    return Bounds(
      northeast: northeast ?? this.northeast,
      southwest: southwest ?? this.southwest,
    );
  }

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}
