import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeLocation extends StatelessWidget {
  const HomeLocation({super.key, required this.nameLocation});

  final String nameLocation;

  @override
  Widget build(BuildContext context) {
    final dayFormat = DateFormat('dd-MM-yyyy');

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/icons/Vector (1).png'),
            SizedBox(width: 10),
            Text(
              nameLocation,
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 17),
        Text(
          dayFormat.format(DateTime.now()),
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      ],
    );
  }
}
