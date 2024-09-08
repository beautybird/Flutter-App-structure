
import 'package:flutter/material.dart';

class SearchAddressProvider with ChangeNotifier{

  List? _addressResultList;

  SearchAddressProvider();

  //Getter
  List? get addressResultList => _addressResultList;

  //Setter
  void setAddressResult(List? addressResult){
    _addressResultList = addressResult;
    notifyListeners();
  }
}