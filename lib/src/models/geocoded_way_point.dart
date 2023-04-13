import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GeocodedWaypoint extends Equatable {
  const GeocodedWaypoint({
    required this.geocoderStatus,
    required this.placeId,
    required this.types,
  });

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) =>
      GeocodedWaypoint(
        geocoderStatus: json["geocoder_status"],
        placeId: json["place_id"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  final String geocoderStatus;
  final String placeId;
  final List<String> types;

  @override
  List<Object> get props => [geocoderStatus, placeId, types];

  @override
  bool get stringify => true;

  GeocodedWaypoint copyWith({
    String? geocoderStatus,
    String? placeId,
    List<String>? types,
  }) =>
      GeocodedWaypoint(
        geocoderStatus: geocoderStatus ?? this.geocoderStatus,
        placeId: placeId ?? this.placeId,
        types: types ?? this.types,
      );

  Map<String, dynamic> toJson() => {
        "geocoder_status": geocoderStatus,
        "place_id": placeId,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}
