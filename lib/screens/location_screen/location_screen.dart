import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yandex_location/data/models/location_model.dart';
import 'package:yandex_location/screens/google_map_screen/google_map_screen.dart';
import 'package:yandex_location/screens/location_screen/widget/update.dart';
import 'package:yandex_location/utils/images/app_images.dart';
import 'package:yandex_location/view_models/map_view_model.dart';

import '../../view_models/locations_view_model.dart';

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
          "My Addresses",
          style: TextStyle(
              color: Colors.black,
              fontFamily: AppImages.fontPoppins,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<PlaceModel>>(
        stream: context.read<LocationsViewModel>().listenProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            List<PlaceModel> places = snapshot.data as List<PlaceModel>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                places.length == 0
                    ? Padding(
                        padding: EdgeInsets.only(top: 200.h),
                        child: const Center(
                          child: Text(
                            "Empty",
                            style: TextStyle(fontSize: 40 , fontFamily: AppImages.fontPoppins),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView(
                          children: [
                            ...List.generate(places.length, (index) {
                              PlaceModel place = places[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: GestureDetector(
                                  onTap: () {
                                    List<String> latlongs =
                                        place.latLng.split(",");
                                    LatLng ll = LatLng(
                                        double.parse(latlongs[1]),
                                        double.parse(latlongs[0]));
                                    context
                                        .read<MapsViewModel>()
                                        .setLatInitialLong(ll);
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => UpdateScreen(
                                                placeModel: place)));
                                  },
                                  child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15.h),
                                      padding: EdgeInsets.all(15.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(0, 4),
                                                spreadRadius: 1,
                                                blurRadius: 40,
                                                color: Colors.grey)
                                          ]),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  AppImages.workIcon,
                                                  width: 30,
                                                  fit: BoxFit.cover),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 200,
                                                    child: Text(
                                                      place.placeName,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  Text(
                                                    place.orientAddress,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<LocationsViewModel>()
                                                    .deleteProduct(
                                                        place.icons, context);
                                              },
                                              child: Icon(
                                                Icons.cancel_outlined,
                                                color: Colors.black,
                                                size: 25,
                                              ))
                                        ],
                                      )),
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => GoogleMapsScreen()));
                      },
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.yellow),
                        child: Center(
                          child: Text(
                            "Add Place",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
