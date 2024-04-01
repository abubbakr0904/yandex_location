import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yandex_location/data/models/location_model.dart';
import 'package:yandex_location/view_models/adress_view_model.dart';
import 'package:yandex_location/view_models/locations_view_model.dart';
import 'package:yandex_location/view_models/map_view_model.dart';
import '../../../utils/images/app_images.dart';

updateBottomShet({
  required BuildContext context,
  required PlaceModel placeModel
}) {
  final TextEditingController name = TextEditingController();
  final TextEditingController flat = TextEditingController();
  final TextEditingController etaj = TextEditingController();
  final TextEditingController dom = TextEditingController();
  final TextEditingController orin = TextEditingController();
  String categoryIcon = "";
  int c = 0;
  _init(){
    name.text = placeModel.placeName;
    // etaj.text = placeModel.stage;
    // dom.text = placeModel.flatNumber;
    orin.text = placeModel.orientAddress;
    // flat.text = placeModel.entrance;
  }
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (context) {
      _init();
      return StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: Container(
              padding: EdgeInsets.all(20.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Location" , style: TextStyle(
                      color : Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppImages.fontPoppins,
                    ),),
                    SizedBox(height: 20.h,),
                    TextField(
                      controller: name,
                      maxLines: null,
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 80.w,
                            child : TextField(
                              keyboardType: TextInputType.number,
                              controller: flat,
                              decoration: const InputDecoration(
                                hintText: "Entrance",
                              ),
                            )
                        ),
                        SizedBox(width: 80.w,
                            child : TextField(
                              keyboardType: TextInputType.number,
                              controller: etaj,
                              decoration: const InputDecoration(
                                hintText: "Floor",
                              ),
                            )
                        ),
                        SizedBox(width: 80.w,
                            child : TextField(
                              keyboardType: TextInputType.number,
                              controller: dom,
                              decoration: const InputDecoration(
                                hintText: "Flat",
                              ),
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    TextField(
                      controller: orin,
                      decoration: const InputDecoration(
                          hintText: "Orientation"
                      ),
                    ),
                    SizedBox(height: 50.h,),
                    GestureDetector(
                        onTap: (){
                          placeModel = placeModel.copyWith(
                            entrance: flat.text,
                            flatNumber: dom.text,
                            stage: etaj.text,
                            orientAddress: orin.text,
                            placeName: name.text,
                          );
                          context.read<LocationsViewModel>().updateProduct(placeModel, context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child : Container(
                          height: 50.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color : Colors.yellow
                          ),
                          child: Center(
                            child: Text("Update" , style: TextStyle(
                                color : Colors.black,
                                fontFamily: AppImages.fontPoppins,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.sp
                            ),),
                          ),
                        )
                    )
                  ],
                ),
              )
          ),
        );
      });
    },
  );
}

void _showToast(BuildContext context, String txt, Color clr) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: clr,
      textColor: Colors.white,
      fontSize: 16.0) as SnackBar);
}