import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_api.dart';
import 'package:weather_app/page/detail/widgets/detail_body.dart';
import 'package:weather_app/providers/weather_api_provider.dart';
import 'package:weather_app/page/search/search_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<List<WeatherDetail>> _futureWeatherDetail;

  @override
  void initState() {
    super.initState();
    _futureWeatherDetail = context.read<WeatherApiProvider>().getWeatherDetail();
  }

  void _searchCity() async {
    final city = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => const SearchPage(),
      ),
    );
    if (city != null && city.isNotEmpty) {
      setState(() {
        _futureWeatherDetail = context.read<WeatherApiProvider>().getWeatherDetailByCity(city);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff1D6CF3), Color(0xff19D2FE)],
        ),
      ),
      child: FutureBuilder(
        future: _futureWeatherDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<WeatherDetail> listData = snapshot.data as List<WeatherDetail>;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: false,
              title: Row(
                children: [
                  Icon(CupertinoIcons.location),
                  SizedBox(width: 15),
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        context.read<WeatherApiProvider>().nameCity,
                        textStyle: TextStyle(fontSize: 20, color: Colors.white),
                        speed: Duration(milliseconds: 100),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(CupertinoIcons.search),
                  onPressed: _searchCity,
                ),
                SizedBox(width: 15),
              ],
            ),
            body: DetailBody(listData: listData),
          );
        },
      ),
    );
  }
}
