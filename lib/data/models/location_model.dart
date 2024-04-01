class   PlaceModel {
  PlaceModel({
    required this.placeCategory,
    required this.placeName,
    required this.entrance,
    required this.flatNumber,
    required this.orientAddress,
    required this.stage,
    required this.icons,
    required this.id,
    required this.latLng
  });

  final String id;
  final String placeName;
  final String placeCategory;
  final String entrance;
  final String stage;
  final String flatNumber;
  final String orientAddress;
  final String icons;
  final String latLng;

  factory PlaceModel.fromJson(Map<String , dynamic> json){
    return PlaceModel(
        placeCategory: json["place_category"] ?? "",
        placeName: json["place_name"] ?? "",
        entrance: json["entrance"] ?? "",
        flatNumber: json["flat_number"] ?? "",
        orientAddress: json["orient_address"] ?? "",
        stage: json["stage"] ?? "",
        icons: json["icons"] ?? "",
        id : json["id"] ?? "",
        latLng : json["latLng"] ?? ""
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
      "id" : id,
      "latLng" : latLng
    };
  }
  Map<String, dynamic> toJsonForUpdate() {
    return {
      'place_name': placeName,
      'entrance': entrance,
      'stage': stage,
      'flat_number': flatNumber,
      'orient_address': orientAddress,
      'icons': icons,
      "latLng" : latLng,
      "id" : id,

    };
  }


  PlaceModel copyWith({
    String? id,
    String? placeName,
    String? placeCategory,
    String? entrance,
    String? stage,
    String? flatNumber,
    String? orientAddress,
    String? icons,
    String? latLng,


  }) {
    return PlaceModel(
        id: id ?? this.id,
        entrance: entrance ?? this.entrance,
        flatNumber: flatNumber ?? this.flatNumber,
        icons: icons ?? this.icons,
        latLng: latLng ?? this.latLng,
        orientAddress: orientAddress ?? this.orientAddress,
        placeCategory: placeCategory ?? this.placeCategory,
        placeName: placeName ?? this.placeName,
        stage: stage ?? this.stage,
    );
  }

}