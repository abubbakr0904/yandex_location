import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yandex_location/utils/images/app_images.dart';

import '../../view_models/adress_view_model.dart';
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
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<AddressesViewModel>(
              builder: (context, viewModel, child) {
                return viewModel.myAddresses.isEmpty
                    ? Center(
                        child: Icon(
                          Icons.not_listed_location_outlined,
                          size: 70.sp,
                        ),
                      )
                    : ListView(children: [
                        ...List.generate(viewModel.myAddresses.length, (index) {
                          var myAddress = viewModel.myAddresses[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return UpdateAddressScreen(
                              //         placeModel: myAddress,
                              //       );
                              //     },
                              //   ),
                              // );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              height: 100,
                              width: double.infinity,
                              color: Colors.blue,
                            ),
                          );
                        })
                      ]);
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=> const GoogleMapsScreen()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.yellow),
              child: Center(
                child: Text(
                  "Yangi address qo'shish",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppImages.fontPoppins,
                      fontSize: 16.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
