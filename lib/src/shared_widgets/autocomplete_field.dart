import 'dart:convert';

import 'package:flutterapp/src/providers/country_city_provider.dart';
import 'package:flutterapp/src/providers/locale_provider.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:flutterapp/src/shared_widgets/form_text_field.dart';
import 'package:flutterapp/src/utilities/classes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';

class AutocompleteField extends StatefulWidget {
  static const routeName = "/autocompleteFieldRoute";
  final SettingsController? controller;

  const AutocompleteField({super.key, this.controller});

  @override
  State<AutocompleteField> createState() => _AutocompleteFieldState();
}

class _AutocompleteFieldState extends State<AutocompleteField> {
  /// Locale
  LocaleProvider? localeProvider;
  String? selectedLocaleCode;

  //
  CountryCityProvider? countryCityProvider;

  //
  var cityController = TextEditingController();

  ///Fetch autocomplete data
  String assetLocation = 'New York';
  List<String>? stringsDataList;

  /// Cities List
  List<String>? citiesCountriesList = CitiesStatesCountries.countriesCities;

  /// Type of data..to use this autocomplete with different fields in same page
  bool currency = false;
  bool city = false;
  bool weight = false;
  bool length = false;

  Future fetchAutoCompleteData() async {
    //stringsDataList = classSource.list;
    if (citiesCountriesList!.isNotEmpty) {
      ///From a String list class file
      stringsDataList = citiesCountriesList;
    } else {
      /// From Asset file as json
      final String? assetData = await rootBundle.loadString(assetLocation);
      final List<dynamic>? json = jsonDecode(assetData!);
      stringsDataList = json!.cast<String>();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    //
    selectedLocaleCode = 'USA';
    //
    fetchAutoCompleteData();
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    localeProvider = Provider.of<LocaleProvider>(context);
    //
    countryCityProvider = Provider.of<CountryCityProvider>(context);
    //
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return stringsDataList!.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      optionsViewBuilder:
          (context, Function(String) onSelectedString, optionsList) {
        return Material(
          elevation: 4.0,
          child: ListView.separated(
            itemBuilder: (context, index) {
              final option = optionsList.elementAt(index);
              return ListTile(
                /*title: Text(
                  option.toString(),
                ),*/
                title: SubstringHighlight(
                  text: option.toString(),
                  term: cityController.text,
                ),
                onTap: () => onSelectedString(
                  option.toString(),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: optionsList.length,
          ),
        );
      },
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        this.cityController = controller;
        return StandardFormTextField(
          controller: controller,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          fieldBorderColor: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontColor: Colors.black,
          prefixIcon: Icons.search,
          prefixIconColor: Colors.black,
          suffixTooltip: 'generalUse-city'.tr().toString(),
          obsecureText: false,
          maxLines: 1,
          validate: (stringFieldValue) => stringFieldValue!.isEmpty == true
              ? 'generalUse-fillAllDetails'.tr().toString()
              : null,
          formTextFieldLabel: 'generalUse-city'.tr().toString(),
          suffixOnPressed: () => controller.clear(),
          onEditingComplete: onEditingComplete,
          focusNode: focusNode,
        );
      },
      onSelected: (String selection) {
        countryCityProvider!.setCityName(null);
        countryCityProvider!.setCityName(selection);
        countryCityProvider!.setCityController(this.cityController);
      },
    );
  }
}
