import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yandex_location/screens/location_screen/location_screen.dart';

import '../../view_models/map_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LocationScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MapsViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Deafult"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: Text("LoTTIE QO"),
        ),
      ),
    );
  }
}