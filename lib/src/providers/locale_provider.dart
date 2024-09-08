
import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier{
  String? _selectedLocaleCode;
  String? _selectedLocaleCountry;
  LocaleProvider(){
    _selectedLocaleCode='en';
    _selectedLocaleCountry= 'US';

  }

  String? get selectedLocaleCode => _selectedLocaleCode;
  void setLocaleCode(String? localeCode){
    _selectedLocaleCode = localeCode;
    notifyListeners();
  }

  String? get selectedLocaleCountry => _selectedLocaleCountry;
  void setLocaleCountry(String? localeCountry){
    _selectedLocaleCountry = localeCountry;
    notifyListeners();
  }
}