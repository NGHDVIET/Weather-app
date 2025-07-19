import 'package:flutter/material.dart';

class HomeDetailWeather extends StatelessWidget {
  const HomeDetailWeather({
    super.key,
    required this.humidity,
    required this.windSpeed,
  });

  final num humidity;
  final num windSpeed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Image.asset('assets/images/icons/Vector.png'),
            Text(
              '${windSpeed}Km/h',
              style: TextStyle(fontSize: 21, color: Colors.white),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset('assets/images/icons/humidity (1).png'),
            Text(
              '${humidity}%',
              style: TextStyle(fontSize: 21, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
