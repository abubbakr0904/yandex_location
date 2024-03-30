import 'dart:convert';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static Future<String> getPlaceNameByLocation(LatLng latLng) async {
    String place = "Hudud noma'lum";

    Uri uri = Uri.https("geocode-maps.yandex.ru", "/1.x/", {
      "apikey": "afa97246-d3e6-422b-875f-b9b63b25c1ab",
      "geocode": "${latLng.longitude}, ${latLng.latitude}",
      "lang": "uz",
      "format": "json",
      "kind": "house",
      "rspn": "1",
      "results": "5"
    });

    http.Response response = await http.get(uri);

    if (response.statusCode == HttpStatus.ok) {
      var data = jsonDecode(response.body);
      var list =
      data["response"]["GeoObjectCollection"]["featureMember"] as List?;
      if (list != null && list.isNotEmpty) {
        String? placeName = list[0]["GeoObject"]["metaDataProperty"]
        ["GeocoderMetaData"]["text"];
        place = placeName ?? "Hudud noma'lum";
      }
    }
    return place;
  }
}