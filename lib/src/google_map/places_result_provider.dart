import 'package:flutter/material.dart';
import 'package:flutterapp/src/google_map/auto_complete_results.dart';


class PlaceResultsProvider with ChangeNotifier {
  List<AutoCompleteResult>? _allReturnedResults;

  PlaceResultsProvider() {
    _allReturnedResults = List.empty(growable: true);
  }

  List<AutoCompleteResult>? get allReturnedResults => _allReturnedResults;
  void setResults(allPlaces) {
    _allReturnedResults = allPlaces;
    notifyListeners();
  }
}

class SearchToggleProvider with ChangeNotifier {
  bool? _searchToggle;

  SearchToggleProvider() {
    _searchToggle = false;
  }

  bool? get searchToggle => _searchToggle;
  void toggleSearch() {
    _searchToggle = !searchToggle!;
    notifyListeners();
  }
}
