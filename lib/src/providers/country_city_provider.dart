import 'package:flutter/material.dart';

class CountryCityProvider with ChangeNotifier {
  String? _cityName;
  String? _countryName;
  TextEditingController? _cityController;

  CountryCityProvider() {
    _cityName = '';
    _countryName = '';
    _cityController = TextEditingController();
  }

  String? get cityName => _cityName;
  void setCityName(String? cityName) {
    _cityName = cityName;
    notifyListeners();
  }

  String? get countryName => _countryName;
  void setCountryName(String? countryName) {
    _countryName = countryName;
    notifyListeners();
  }

  TextEditingController? get cityController => _cityController;
  void setCityController(TextEditingController? cityController){
    _cityController = cityController;
    notifyListeners();
  }
}











