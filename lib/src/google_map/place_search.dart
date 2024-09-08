
/*
Step 1
* This when user enter address to search it
* so we collect the description of the place and the place_id
* that we use later to get the coordinates of the place
* */

class PlaceSearch {
  final String? description;
  final String? placeId;

  PlaceSearch({this.description, this.placeId});

  factory PlaceSearch.fromJason(Map<String, dynamic> jason) {
    return PlaceSearch(
        description: jason['description'], placeId: jason['place_id']
    );
  }
}
