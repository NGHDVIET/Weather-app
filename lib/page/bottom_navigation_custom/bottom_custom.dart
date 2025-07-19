import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/page/detail/detail_page.dart';
import 'package:weather_app/page/home/home_page.dart';
import 'package:weather_app/providers/weather_api_provider.dart';

class BottomNavigationCustom extends StatefulWidget {
  const BottomNavigationCustom({super.key});

  @override
  State<BottomNavigationCustom> createState() => _BottomNavigationCustomState();
}

class _BottomNavigationCustomState extends State<BottomNavigationCustom> {
  List<BottomNavigationBarItem> listItem = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.list_bullet),
      label: 'List',
    ),
  ];

  List<Widget> listPages = [HomePage(), DetailPage()];
  int activePage = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      print('Bắt đầu kiểm tra location service...');
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print('Location service enabled: ' + serviceEnabled.toString());
      if (!serviceEnabled) {
        print('Location service chưa bật.');
        setState(() => _loading = false);
        return;
      }
      print('Kiểm tra quyền truy cập vị trí...');
      LocationPermission permission = await Geolocator.checkPermission();
      print('Quyền hiện tại: ' + permission.toString());
      if (permission == LocationPermission.denied) {
        print('Chưa có quyền, đang yêu cầu quyền...');
        permission = await Geolocator.requestPermission();
        print('Kết quả sau khi yêu cầu quyền: ' + permission.toString());
        if (permission == LocationPermission.denied) {
          print('Quyền vẫn bị từ chối.');
          setState(() => _loading = false);
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        print('Quyền bị từ chối vĩnh viễn.');
        setState(() => _loading = false);
        return;
      }
      print('Đang lấy vị trí hiện tại...');
      Position position = await Geolocator.getCurrentPosition();
      print('Lấy được vị trí: ' + position.toString());
      if (mounted) {
        print('Cập nhật vị trí vào Provider...');
        context.read<WeatherApiProvider>().updatePosition(position);
        setState(() => _loading = false);
        print('Hoàn thành khởi tạo location!');
      }
    } catch (e) {
      print('Lỗi khi lấy vị trí: ' + e.toString());
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      extendBody: true,
      body: listPages[activePage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activePage,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        backgroundColor: Colors.white12,
        elevation: 0,
        onTap: (index) {
          setState(() {
            activePage = index;
          });
        },
        items: listItem,
      ),
    );
  }
}
