
import 'package:flutter/cupertino.dart';

class CompanyLocationProvider with ChangeNotifier{

  String? _streetLocation;
  double? _latValue;
  double? _lngValue;
  String? _cityName;

  CompanyLocationProvider(){
    _streetLocation ='';
    _latValue = 0.0;
    _lngValue = 0.0;
    _cityName = '';
  }

  String? get streetLocation => _streetLocation;
  void setStreetLocation(String street){
    _streetLocation = street;
    notifyListeners();
  }
  double? get latValue => _latValue;
  void setLatValue(double? lat){
    _latValue = lat;
    notifyListeners();
  }
  double? get lngValue => _lngValue;
  void setLngValue(double? lng){
    _lngValue = lng;
    notifyListeners();
  }

  String? get cityName => _cityName;
  void setCityName(String city){
    _cityName = city;
    notifyListeners();
  }
}