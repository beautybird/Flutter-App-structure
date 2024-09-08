import 'package:flutter/cupertino.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsSearchProvider with ChangeNotifier {
  List<Map>? _productsSearchList;
  int? _index;
  int? _finalItemOrderedQty;
  String? _itemDetails;
  int? _itemQty;
  int? _itemPrice;
  int? _itemTotalAmount;
  String? _itemImageOne;
  String? _itemImageTwo;
  String? _itemImageThree;
  String? _itemImageFour;
  int? _orderTotalDeliveryAmount;
  int? _orderTotalAmount;
  String? _category;
  User? _userId;

  ProductsSearchProvider() {
    _productsSearchList = [];
    _index = 0;
    _itemDetails = '';
    _itemQty = 0;
    _itemPrice = 0;
    _itemTotalAmount = 0;
    _itemImageOne = '';
    _itemImageTwo = '';
    _itemImageThree = '';
    _itemImageFour = '';
    _orderTotalDeliveryAmount = 0;
    _orderTotalAmount = 0;
    _finalItemOrderedQty = 0;
    _category = '';
  }

  List<Map>? get productsSearchList => _productsSearchList;
  void setProductsSearchList(List<Map>? productsSearchList) {
    _productsSearchList = productsSearchList;
    notifyListeners();
  }

  int? get index => _index;
  void setIndexValue(int? index) {
    _index = index;
    notifyListeners();
  }

  int? get finalItemOrderedQty => _finalItemOrderedQty;
  void setFinalItemOrderedQty(int? finalOrderedItemQty) {
    _finalItemOrderedQty = finalOrderedItemQty;
    notifyListeners();
  }

  String? get category => _category;
  void setCategory(String? category) {
    _category = category;
    notifyListeners();
  }

  User? get userId => _userId;
  void setUserId(User? userId) {
    _userId = userId;
    notifyListeners();
  }
}
