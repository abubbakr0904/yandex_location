import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:yandex_location/data/models/location_model.dart';
import 'package:yandex_location/utils/images/app_images.dart';
import 'package:yandex_location/view_models/location_view_model.dart';

import '../../view_models/adress_view_model.dart';
import '../../view_models/locations_view_model.dart';
import '../google_map_screen/google_map_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "May Addresses",
          style: TextStyle(
              color: Colors.black,
              fontFamily: AppImages.fontPoppins,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            PlaceModel pl = PlaceModel(placeCategory: "Home", placeName: "Ozbek", entrance: "2", flatNumber: "2", orientAddress: "ANdalis", stage: "a", icons: AppImages.navigator);
            context.read<LocationsViewModel>().insertProducts(pl, context);
          }, icon: Icon(
            Icons.add_location,
            color : Colors.black
          ))
        ],
      ),
      body: StreamBuilder<List<PlaceModel>>(
        stream: context.read<LocationsViewModel>().listenProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            List<PlaceModel> places = snapshot.data as List<PlaceModel>;
            return ListView(
              children: [
                ...List.generate(places.length, (index) {
                  PlaceModel place = places[index];
                  return ListTile(
                    leading: Image.asset(
                      place.icons,
                      width: 100.w,
                    ),
                    title: Text(
                      place.placeName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontFamily: AppImages.fontPoppins),
                    ),
                    subtitle: Text(
                      place.placeName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontFamily: AppImages.fontPoppins),
                    ),
                  );
                })
              ],
            );
          }
          return const Center(
            child : CircularProgressIndicator()
          );
        },
      ),
    );
  }
}
