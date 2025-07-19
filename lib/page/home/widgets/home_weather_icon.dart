import 'package:flutter/material.dart';
import 'package:weather_app/apps/utils/const.dart';

class HomeWeatherIcon extends StatelessWidget {
  const HomeWeatherIcon({super.key, required this.nameIcon});

  final String nameIcon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width / 1.5,
      padding: EdgeInsets.all(20),
      child: Image.asset(AssetCustom.getLinkImg(nameIcon), fit: BoxFit.cover),
    );
  }
}
