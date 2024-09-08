
import 'package:flutter/material.dart';

class AdvertisementProvider with ChangeNotifier{

  String? _selectedImage;
  String? _selectedVideo;
  List? _selectedImagesList;
  List? _selectedVideosList;
  String? _selectedDefaultVideo;
  bool? _advertisementAreaVisible;

  AdvertisementProvider(){
    _selectedImage = '';
    _selectedVideo = '';
    _selectedImagesList = [];
    _selectedVideosList = [];
    _advertisementAreaVisible = false;
  }

  String? get selectedImage => _selectedImage;
  void setSelectedImage(String? image){
    _selectedImage = image;
    notifyListeners();
  }
  String? get selectedVideo => _selectedVideo;
  void setSelectedVideo(String? video){
    _selectedVideo = video;
    notifyListeners();
  }
  List? get selectedImagesList => _selectedImagesList;
  void setImagesList(List? photos){
    _selectedImagesList = photos;
    notifyListeners();
  }
  List? get selectedVideosList => _selectedVideosList;
  void setVideosList(List? videos){
    _selectedVideosList = videos;
    notifyListeners();
  }

  String? get selectedDefaultVideo => _selectedDefaultVideo;

  bool? get advertisementAreaVisible => _advertisementAreaVisible;
  void setAdvertisementAreaVisible(bool? visible){
    _advertisementAreaVisible = visible;
    notifyListeners();
  }
}