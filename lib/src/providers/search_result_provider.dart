


import 'package:flutter/material.dart';

class SearchResultProvider with ChangeNotifier{

  List<List?>? _searchResultList;
  List<List?>? _nutsSearchResultList;
  List<List?>? _chocolateSearchResultList;
  List<List?>? _fruitsSearchResultList;
  int? _shopID;


  SearchResultProvider(){
    _searchResultList = List.empty(growable: true);
    _nutsSearchResultList = List.empty(growable: true);
    _chocolateSearchResultList = List.empty(growable: true);
    _fruitsSearchResultList = List.empty(growable: true);
    _shopID = 0;
  }

  List<List?>? get searchResultList => _searchResultList;
  void setSearchResultList(List<List>? searchResultList){
    _searchResultList = searchResultList;
    notifyListeners();
  }

  List<List?>? get nutSearchResultList => _nutsSearchResultList;
  void setNutResultList(List<List>? nutResultList){
    _nutsSearchResultList = nutResultList;
    notifyListeners();
  }

  List<List?>? get chocolateSearchResultList => _chocolateSearchResultList;
  void setChocolateResultList(List<List>? chocolateResultList){
    _chocolateSearchResultList = chocolateResultList;
    notifyListeners();
  }

  List<List?>? get fruitsSearchResultList => _fruitsSearchResultList;
  void setFruitsResultList(List<List>? fruitsResultList){
    _fruitsSearchResultList = fruitsResultList;
    notifyListeners();
  }

  int? get shopId => _shopID;
  void setShopID(int? shopID){
    _shopID = shopID;
    notifyListeners();
  }

}