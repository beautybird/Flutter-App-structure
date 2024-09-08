
import 'package:flutterapp/src/providers/selected_currency.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:flutterapp/src/utilities/classes.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownList extends StatefulWidget {
  static const routeName = "/dropdownListRoute";
  final SettingsController? controller;
  final String? label;

  const DropdownList({super.key, this.controller, this.label});

  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  //
  List<String>? currenciesList;
  //
  String? selectedValue;
  //
  SelectedCurrencyProvider? selectedCurrencyProvider;
  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    currenciesList = Currencies.currencies;
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    selectedCurrencyProvider = Provider.of<SelectedCurrencyProvider>(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Row(
          children: [
            Icon(
              Icons.list,
              size: 20.0,
              color: Colors.red,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Icon(
                CarbonIcons.currency,
                size: 30.0,
              ),
            ),
          ],
        ),
        items: currenciesList!
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
            selectedCurrencyProvider!.setSelectedCurrency(null);
            selectedCurrencyProvider!.setSelectedCurrency(selectedValue);
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 60,
          width: 180,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.grey.shade100,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.red,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.grey.shade100,
          ),
          offset: const Offset(50, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all<double>(6),
            thumbVisibility: WidgetStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
