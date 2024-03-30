import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yandex_location/screens/google_map_screen/widgets/show_dialog.dart';

import '../../utils/images/app_images.dart';
import '../../view_models/map_view_model.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({
    super.key,
  });

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  int c = 0;
  String icon = '';
  String category = '';
  late LatLng latLng;
  @override
  Widget build(BuildContext context) {
    context.read<MapsViewModel>();
    CameraPosition? cameraPosition;
    return Scaffold(
      body: Consumer<MapsViewModel>(
        builder: (context, viewModel, child) {
          return Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                markers: viewModel.markers,
                onCameraIdle: () {
                  if (cameraPosition != null) {
                    context
                        .read<MapsViewModel>()
                        .changeCurrentLocation(cameraPosition!);
                  }
                  // ScaffoldMessenger.of(context)
                  //     .showSnackBar(const SnackBar(content: Text("IDLE")));
                },
                onCameraMove: (CameraPosition currentCameraPosition) {
                  cameraPosition = currentCameraPosition;
                  latLng = currentCameraPosition.target;
                  debugPrint(
                      "CURRENT POSITION:${currentCameraPosition.target.longitude}");
                },
                mapType: MapType.normal,
                initialCameraPosition: viewModel.initialCameraPosition!,
                onMapCreated: (GoogleMapController createdController) {
                  viewModel.controller.complete(createdController);
                },
              ),
              Align(
                child: Image.asset(
                  AppImages.pin,
                  width: 50,
                  height: 50,
                ),
              ),
              Positioned(
                top: 100,
                right: 0,
                left: 0,
                child: Text(
                  viewModel.currentPlaceName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 27.sp,
                    fontWeight: FontWeight.w600,
                    color : Colors.black,
                    fontFamily: AppImages.fontPoppins
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 156.h,
                  padding: EdgeInsets.all(20.w),
                  child : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap : (){
                              c = 1;
                              icon = AppImages.homeIcon;
                              category = "Home";
                              setState(() {

                              });
                            },
                            child: Container(
                              padding : EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color : c == 1 ? Colors.yellow : Colors.white
                              ),
                              child : Row(
                                children: [
                                  SvgPicture.asset(AppImages.homeIcon , height: 20.w,fit : BoxFit.cover),
                                  SizedBox(width: 7.w,),
                                  Text("Home" , style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppImages.fontPoppins
                                  ),)
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              c = 2;
                              icon = AppImages.workIcon;
                              category = "Work";
                              setState(() {

                              });
                            },
                            child: Container(
                              padding : EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color : c == 2 ? Colors.yellow : Colors.white
                              ),
                              child : Row(
                                children: [
                                  SvgPicture.asset(AppImages.workIcon , height : 20.w , fit : BoxFit.cover),
                                  SizedBox(width: 7.w,),
                                  Text("Work" , style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppImages.fontPoppins
                                  ),)
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              c = 3;
                              icon = AppImages.locationIcon;
                              category = "Other";
                              setState(() {

                              });
                            },
                            child: Container(
                              padding : EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color : c == 3 ? Colors.yellow : Colors.white
                              ),
                              child : Row(
                                children: [
                                  SvgPicture.asset(AppImages.locationIcon , height : 20.w , fit : BoxFit.cover),
                                  SizedBox(width: 7.w,),
                                  Text("Other" , style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppImages.fontPoppins
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h,),
                      GestureDetector(
                        onTap: (){
                          print("AAAAAAAAAAAAAAA $category");
                          textFieldDialog(context: context, ltln:latLng, image: icon, placeName: viewModel.currentPlaceName , category: category);
                        },
                        child : Container(
                          height: 50.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color : Colors.yellow
                          ),
                          child: Center(
                            child: Text("Save" , style: TextStyle(
                              color : Colors.black,
                              fontFamily: AppImages.fontPoppins,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp
                            ),),
                          ),
                        )
                      )
                    ],
                  )
                ),
              )
            ],
          );
        },
      ),
    );
  }
}