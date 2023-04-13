import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LegPolyline extends Equatable {
  const LegPolyline({
    required this.points,
  });

  factory LegPolyline.fromJson(Map<String, dynamic> json) => LegPolyline(
        points: json["points"],
      );

  final String points;

  @override
  List<Object> get props => [points];

  @override
  bool get stringify => true;

  LegPolyline copyWith({
    String? points,
  }) =>
      LegPolyline(
        points: points ?? this.points,
      );

  Map<String, dynamic> toJson() => {
        "points": points,
      };
}
