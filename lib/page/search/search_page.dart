import 'package:flutter/material.dart';
import 'widgets/city_list.dart';
import 'widgets/city_suggestion_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  final List<Map<String, String>> _allCities = allCities;
  List<Map<String, String>> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final input = _controller.text.trim().toLowerCase();
    setState(() {
      if (input.isEmpty) {
        _suggestions = [];
      } else {
        _suggestions = _allCities
            .where((city) => city['display']!.toLowerCase().contains(input))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff1D6CF3), Color(0xff19D2FE)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Search City',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Icon(
                      Icons.location_on_rounded,
                      size: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Enter the city name to check the weather',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        children: [
                          TextField(
                            controller: _controller,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xff1D6CF3),
                              ),
                              labelText: 'City name',
                              errorText: _errorText,
                              labelStyle: const TextStyle(
                                color: Color(0xff1D6CF3),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                            ),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (_) => _onSearch(),
                          ),
                          if (_suggestions.isNotEmpty)
                            CitySuggestionList(
                              suggestions: _suggestions,
                              onTap: (display, api) {
                                _controller.text = display;
                                _onSearch(api);
                              },
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _onSearch,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xff1D6CF3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSearch([String? apiCity]) {
    final city = _controller.text.trim();
    if (city.isEmpty) {
      setState(() {
        _errorText = 'Please enter a city name';
      });
      return;
    }
    // Nếu có apiCity (tức là chọn từ gợi ý), trả về apiCity, còn không thì tìm trong _allCities
    String cityForApi = apiCity ??
        (_allCities.firstWhere(
          (c) => c['display'] == city,
          orElse: () => {'api': city},
        )['api']!);
    Navigator.of(context).pop(cityForApi);
  }
}
