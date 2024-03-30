import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../data/models/category_model.dart';
import '../data/models/location_model.dart';
import '../data/network/api_provider.dart';
import '../utils/images/app_images.dart';

class MapsViewModel extends ChangeNotifier {
  MapsViewModel() {
    getUserLocation();
  }

  String currentPlaceName = "";

  final Completer<GoogleMapController> controller =
  Completer<GoogleMapController>();

  MapType mapType = MapType.normal;

  late CameraPosition initialCameraPosition;
  late CameraPosition currentCameraPosition;
  Set<Marker> markers = {};

  List<PlaceModel> myAddresses = [];

  setLatInitialLong(LatLng latLng) {
    initialCameraPosition = CameraPosition(
      target: latLng,
      zoom: 15,
    );
    notifyListeners();
  }

  changeMapType(MapType newMapType) {
    mapType = newMapType;
    notifyListeners();
  }

  moveToInitialPosition() async {
    final GoogleMapController mapController = await controller.future;
    await mapController
        .animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition!));
  }

  changeCurrentCameraPosition(CameraPosition cameraPosition) async {
    final GoogleMapController mapController = await controller.future;
    await mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  changeCurrentLocation(CameraPosition cameraPosition) async {
    currentCameraPosition = cameraPosition;
    currentPlaceName =
    await ApiProvider.getPlaceNameByLocation(cameraPosition.target);
    notifyListeners();
  }

  addNewMarker(PlaceModel placeModel) async {
    // markers = {};

    Uint8List? markerImage;

    switch (placeModel.placeCategory) {
      case "Work":
        print("work");
        markerImage = await getBytesFromAsset(
          AppImages.workIcon,
          100,
        );
        break;
      case "Home":
        print("home");
        markerImage = await getBytesFromAsset(
          AppImages.homeIcon,
          150
        );
       case "Other":
         print("other");
         markerImage = await getBytesFromAsset(
          AppImages.location,
          150,
        );
      default:
        print("wosdfrk");
        markerImage = await getBytesFromAsset(
          AppImages.location,
          150,
        );
    }

    markers.add(
      Marker(
        position: placeModel.latLng,
        infoWindow: InfoWindow(
          title: placeModel.placeName,
          snippet: placeModel.placeCategory,
        ),
        //BitmapDescriptor.defaultMarker,
        icon: BitmapDescriptor.fromBytes(markerImage),
        markerId: MarkerId(DateTime.now().toString()),
      ),
    );
    notifyListeners();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  savePlace(PlaceModel placeModel) {
    myAddresses.add(placeModel);
    addNewMarker(placeModel);
  }

  Future<void> getUserLocation() async {
    Location location = Location();
    bool serviceEnabled = false;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    setLatInitialLong(LatLng(locationData.latitude!, locationData.longitude!));

    debugPrint("LONGITUDE:${locationData.longitude}");
    debugPrint("LATITUDE:${locationData.latitude}");
    debugPrint("SPEED:${locationData.speed}");
    debugPrint("ALTITUDE:${locationData.altitude}");

    //listenCurrentLocation();

    //location.enableBackgroundMode(enable: true);
  }
}