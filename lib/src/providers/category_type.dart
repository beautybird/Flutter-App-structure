import 'package:flutter/material.dart';

class SelectedCategoryProvider with ChangeNotifier {
  String? _type;
  String? _mixNuts;
  String? _mixChocolates;
  String? _mixFruits;

  SelectedCategoryProvider() {
    _type = "";
    _mixNuts = "";
    _mixChocolates = "";
    _mixFruits = "";
  }

  String? get type => _type;
  void setType(String? type) {
    _type = type;
    notifyListeners();
  }

  String? get mixNuts => _mixNuts;
  void setMixNuts(String? mixNuts) {
    _mixNuts = mixNuts;
    notifyListeners();
  }

  String? get mixChocolates => _mixChocolates;
  void setMixChocolates(String? mixChocolates) {
    _mixChocolates = mixChocolates;
    notifyListeners();
  }

  String? get mixFruits => _mixFruits;
  void setMixFruits(String? mixFruits) {
    _mixFruits = mixFruits;
    notifyListeners();
  }
}
