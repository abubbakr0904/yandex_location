import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'category_model.dart';

class PlaceModel {
  PlaceModel({
    required this.placeCategory,
    required this.latLng,
    required this.placeName,
    required this.entrance,
    required this.flatNumber,
    required this.orientAddress,
    required this.stage,
    required this.icons,
    this.id,
  });

  final int? id;
  LatLng latLng;
  final String placeName;
  final String placeCategory;
  final String entrance;
  final String stage;
  final String flatNumber;
  final String orientAddress;
  final String icons;

  factory PlaceModel.fromJson(Map<String , dynamic> json){
    return PlaceModel(
        placeCategory: json["placeCategory"],
        latLng: json["latLng"],
        placeName: json["place_name"],
        entrance: json["entrance"],
        flatNumber: json["flat_number"],
        orientAddress: json["orient_address"],
        stage: json["stage"],
        icons: json["icons"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_category': placeCategory.toString(),
      'place_name': placeName,
      'entrance': entrance,
      'stage': stage,
      'flat_number': flatNumber,
      'orient_address': orientAddress,
      'icons': icons,
      'lat_Lng': "${latLng.latitude},${latLng.longitude}"
    };
  }


}