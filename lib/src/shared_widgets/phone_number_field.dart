import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/src/providers/locale_provider.dart';
import 'package:flutterapp/src/providers/phone_number_provider.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';

class PhoneNumberField extends StatefulWidget {
  static const routeNumber = "/phoneNumberFieldRoute";
  final SettingsController? controller;

  const PhoneNumberField({super.key, this.controller});

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  ///Locale
  LocaleProvider? localeProvider;
  String? selectedLocaleCode;

  ///Phone provider
  PhoneNumberProvider? phoneNumberProvider;

  PhoneNumberInputController? _phoneFieldController;

  String? _phoneNumberValue;
  String? _getPhoneNumberLatestValue() {
    return _phoneNumberValue = ((_phoneFieldController!.phoneNumber).isNotEmpty
        ? _phoneFieldController!.fullPhoneNumber
        : '');
  }
  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    _phoneNumberValue = '';
    _phoneFieldController = PhoneNumberInputController(context);
    _phoneFieldController!.addListener(() {
      _getPhoneNumberLatestValue();
    });
  }

  @override
  void dispose() {
    _phoneFieldController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    localeProvider = Provider.of<LocaleProvider>(context);
    //
    phoneNumberProvider = Provider.of<PhoneNumberProvider>(context);
    //
    //_phoneFieldController = PhoneNumberInputController(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*const SizedBox(
            height: 20,
          ),
          const Text('bottom sheet mode'),
          const PhoneNumberInput(
            initialCountry: 'SA',
            locale: 'it',
            countryListMode: CountryListMode.bottomSheet,
            contactsPickerPosition: ContactsPickerPosition.suffix,
          ),
          const SizedBox(
            height: 50,
          ),
          const Text('dialog mode'),*/
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: PhoneNumberInput(
              controller: _phoneFieldController,
              initialValue: '+123 4567890123',
              initialCountry: 'USA',
              excludedCountries: [],
              errorText: 'Error',
              locale: 'en',
              countryListMode: CountryListMode.dialog,
              contactsPickerPosition: ContactsPickerPosition.suffix,
              hint: 'Mobile #',
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.purple)),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green),
              ),
              onChanged: (numberValue) {
                //
                if (numberValue.length > _phoneNumberValue!.length) {
                  phoneNumberProvider!.setPhoneNumber('');
                  _phoneNumberValue = numberValue;
                } else {
                  phoneNumberProvider!.setPhoneNumber('');
                  phoneNumberProvider!.setPhoneNumber(_phoneNumberValue!);
                }
              },
            ),
          ),
          /*const SizedBox(
            height: 50,
          ),
          const Text('custom border & custom controller'),
          PhoneNumberInput(
            initialCountry: 'TN',
            locale: 'ar',
            controller: PhoneNumberInputController(
              context,
            ),
            countryListMode: CountryListMode.dialog,
            contactsPickerPosition: ContactsPickerPosition.suffix,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.purple)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.purple)),
            errorText: 'error',
          ),
          const SizedBox(
            height: 50,
          ),
          const Text('bottom picker widget with custom widget'),
          const PhoneNumberInput(
            initialCountry: 'YE',
            locale: 'it',
            countryListMode: CountryListMode.dialog,
            contactsPickerPosition: ContactsPickerPosition.bottom,
            pickContactIcon: Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'select from contacts',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text('custom picker icon , no flag, hint'),
          const PhoneNumberInput(
            locale: 'it',
            countryListMode: CountryListMode.bottomSheet,
            contactsPickerPosition: ContactsPickerPosition.suffix,
            pickContactIcon: Icon(Icons.add),
            showSelectedFlag: false,
            hint: 'XXXXXXXXXXX',
          ),*/
        ],
      ),
    );
  }
}
