

import 'package:flutter/material.dart';

class StatefulProvider with ChangeNotifier{

  String? _imageOneAddress;
  String? _imageTwoAddress;
  String? _currentImage;

  StatefulProvider(){
    _imageOneAddress = "assets/images/art-blue1.png";
    _imageTwoAddress = "assets/images/makeup4.jpg";
    _currentImage = "assets/images/noproduct.png";
  }
  String? get imageOneAddress => _imageOneAddress;
  void setImageOneAddress(String? imageOne){
    _imageOneAddress = imageOne;
    notifyListeners();
  }

  String? get imageTwoAddress => _imageTwoAddress;
  void setImageTwoAddress(String? imageTwo){
    _imageTwoAddress = imageTwo;
    notifyListeners();
  }

  String? get currentImage => _currentImage;
  void setCurrentImage(String? currentImage){
    _currentImage = currentImage;
    notifyListeners();
  }

  void changeImage(){
    if(_currentImage!.contains(_imageOneAddress!)){
      _currentImage = _imageTwoAddress;
      notifyListeners();
    }else{
      _currentImage = _imageOneAddress;
      notifyListeners();
    }
  }
}