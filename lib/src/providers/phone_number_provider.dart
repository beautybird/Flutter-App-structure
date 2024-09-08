
import 'package:flutter/cupertino.dart';

class PhoneNumberProvider with ChangeNotifier{
  String? _phoneNumber;
  PhoneNumberProvider(){
    _phoneNumber = '';
  }

  String? get phoneNumber => _phoneNumber;
  void setPhoneNumber(String phone){
    _phoneNumber = phone;
    notifyListeners();
  }
}