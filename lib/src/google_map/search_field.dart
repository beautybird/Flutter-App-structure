import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/src/google_map/auto_complete_results.dart';
import 'package:flutterapp/src/google_map/map_location_provider.dart';
import 'package:flutterapp/src/google_map/map_service.dart';
import 'package:flutterapp/src/google_map/place_search.dart';
import 'package:flutterapp/src/google_map/places_result_provider.dart';
import 'package:flutterapp/src/providers/locale_provider.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:flutterapp/src/shared_widgets/text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class StreetLocationSearchField extends StatefulWidget {
  static const routeName = "/searchFieldRoute";
  final SettingsController? controller;

  const StreetLocationSearchField({super.key, this.controller});

  @override
  State<StreetLocationSearchField> createState() =>
      _StreetLocationSearchFieldState();
}

class _StreetLocationSearchFieldState extends State<StreetLocationSearchField> {
  ///Locale Provider
  LocaleProvider? localeProvider;
  String? selectedLocaleCode;

  ///Controller
  final _searchFieldController = TextEditingController();

  List<PlaceSearch>? placesSearchResults;

  // This used for the google map
  String kGoogleApiKey = ''; // Add Google API key here

  ///provider to save the coordinates of the location
  CompanyLocationProvider? companyLocationProvider;

  ///Places Search Provider
  PlaceResultsProvider? placeResultsProvider;
  SearchToggleProvider? searchFlag;

  ///If user type location fast
  Timer? _debounce;

  ///Markers
  Set<Marker> _markers = Set<Marker>();

  ///
  //Toggling UI as we need;
  bool searchToggle = false;
  bool radiusSlider = false;
  bool cardTapped = false;
  bool pressedNear = false;
  bool getDirections = false;

  ///
  List<AutoCompleteResult>? searchResults;
  //

  @override
  void initState() {
    // TODO: implement initState
    placesSearchResults = List.empty(growable: true);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchFieldController.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Applying new selected locale on this page
    localeProvider = Provider.of<LocaleProvider>(context);
    selectedLocaleCode = localeProvider!.selectedLocaleCode;
    //
    companyLocationProvider = Provider.of<CompanyLocationProvider>(context);
    //
    placeResultsProvider = Provider.of<PlaceResultsProvider>(context);
    searchFlag = Provider.of<SearchToggleProvider>(context);
    //
    return Stack(
      children: [
        TextFieldStandard(
          controller: _searchFieldController,
          textInputType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
          fieldBorderColor: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontColor: Colors.black,
          prefixIcon: Icons.streetview,
          prefixIconColor: Colors.black,
          suffixTooltip: 'generalUse-street'.tr().toString(),
          obsecureText: false,
          maxLines: 1,
          labelText: 'generalUse-street'.tr().toString(),
          matches: null,
          validate: (streetFieldValue) => streetFieldValue!.isEmpty
              ? 'generalUse-fillDetails'.tr().toString()
              : null,
          onTap: () {},
          onChanged: (mapSearchFiledValue) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(Duration(milliseconds: 700), () async {
              if (mapSearchFiledValue.length > 2) {
                if (!searchFlag!.searchToggle!) {
                  searchFlag!.toggleSearch();
                  _markers = {};
                }

                searchResults =
                    await MapServices().searchPlaces(mapSearchFiledValue);

                placeResultsProvider!.setResults(searchResults);
              } else {
                List<AutoCompleteResult> emptyList = [];
                placeResultsProvider!.setResults(emptyList);
              }
            });
          },
          onFieldSubmitted: (stringValue) {},
          onEditingComplete: () {},
          suffixOnPressed: () => _searchFieldController.clear(),
        ),
        searchFlag!.searchToggle!
            ? placeResultsProvider!.allReturnedResults!.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 60.0,
                      ),
                      Container(
                        height: 200.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.7),
                        ),
                        child: ListView(
                          children: [
                            ...placeResultsProvider!.allReturnedResults!
                                .map((e) => buildListItem(e, searchFlag))
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 60.0,
                      ),
                      Container(
                        height: 200.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.7),
                        ),
                        child: Center(
                          child: Column(children: [
                            Text(
                              'generalUse-queryFailed'.tr().toString(),
                              style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 5.0),
                            Container(
                              width: 125.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  searchFlag!.toggleSearch();
                                },
                                child: const Center(
                                  child: Text(
                                    'Close this',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ],
                  )
            : Container(),
      ],
    );
  }

  Widget buildListItem(AutoCompleteResult placeItem, searchFlag) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTapDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onTap: () async {
          var place = await MapServices().getPlace(placeItem.placeId);
          var latitude = place['geometry']['location']['lat'];
          var longitude = place['geometry']['location']['lng'];

          companyLocationProvider!.setLatValue(null);
          companyLocationProvider!.setLngValue(null);

          companyLocationProvider!.setLatValue(latitude);
          companyLocationProvider!.setLngValue(longitude);
          companyLocationProvider!.setStreetLocation(placeItem.description!);

          ///set selected place to the Street field
          _searchFieldController.text = placeItem.description!;

          ///close the search list
          searchFlag.toggleSearch();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Icon(
                Icons.location_on,
                color: Colors.green,
                size: 20.0,
              ),
            ),
            SizedBox(width: 4.0),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    placeItem.description ?? '',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
