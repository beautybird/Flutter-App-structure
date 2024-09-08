import 'package:flutter/material.dart';

class SelectedCurrencyProvider with ChangeNotifier{

  String? _selectedCurrency;

  SelectedCurrencyProvider(){
    _selectedCurrency = '';
  }

  String? get selectedCurrency => _selectedCurrency;
  void setSelectedCurrency(String? currency){
    _selectedCurrency = currency;
    notifyListeners();
  }
}