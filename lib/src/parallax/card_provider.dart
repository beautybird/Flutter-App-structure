import 'package:flutter/material.dart';

class CardProvider with ChangeNotifier {
  String? _assetPath;
  bool? _isSelected;
  GlobalKey? _mediaKey;
  String? _category;
  int? _mediaIndex;

  CardProvider() {
    _assetPath = '';
    _isSelected = true;
    _mediaKey = GlobalKey();
    _category = '';
    _mediaIndex = 0;
  }

  String? get assetPath => _assetPath;
  void setAssetPath(String? path) {
    _assetPath = path;
    notifyListeners();
  }

  bool? get isSelected => _isSelected;
  void setIsSelected(bool? selected) {
    _isSelected = selected;
    notifyListeners();
  }

  GlobalKey? get mediaKey => _mediaKey;
  void setMediaKey(GlobalKey? key) {
    _mediaKey = key;
    notifyListeners();
  }

  String? get category => _category;
  void setCategory(String? category){
    _category = category;
    notifyListeners();
  }

  int? get mediaIndex => _mediaIndex;
  void setMediaIndex(int? mediaIndex){
    _mediaIndex = mediaIndex;
    notifyListeners();
  }
}
