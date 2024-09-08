import 'package:flutter/material.dart';


////////////
class DropDownButtonStandard extends StatelessWidget {

  List<String>? listItems;
  String? value;

  Function(String?)? onChanged;
  Widget? hintDetails;

  Widget? disabledHintDetails;
  Icon? icon;
  List<DropdownMenuItem<String>>? items;
  TextStyle style = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );


  DropDownButtonStandard({ this.value,
    this.onChanged, this.hintDetails,this.disabledHintDetails, this.icon, this.items});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      hint: hintDetails,
      disabledHint: disabledHintDetails,
      icon: icon,
      iconSize: 25.0,
      iconEnabledColor: Colors.white,
      iconDisabledColor: Colors.grey,
      elevation: 15,
      style: style,
      itemHeight: kMinInteractiveDimension,
      underline: Container(
        height: 2,
        width: 100,
        color: Colors.amberAccent,
      ),
      isDense: false,
      isExpanded: false,
      focusNode: FocusNode(),
      autofocus: false,
      focusColor: Colors.lightGreen[50],
      onChanged: onChanged,
      /* selectedItemBuilder: (context){
        return list_items.map<Widget>((String item) { return Text(item);}).toList();
        },*/
      items: items,
    );
  }
}

/*....The countries list.json drop down widget ...*/
class Categories_List extends StatefulWidget {

  @override
  _Categories_ListState createState() => _Categories_ListState();
}

class _Categories_ListState extends State<Categories_List> {
  /*...Categories names list ...*/
  List<String> categories_names_list = [
    'supplement',
    'body_building',
    'makeup',
    'jewelery',
    'clothes'
  ];

  /*..The default value shown in the drop down button should be null*/
  static String? dropdownValue ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      hint: Text(
        'Select Country',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          letterSpacing: 2.0,
        ),
      ),
      disabledHint: Text(
        'No List Active',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          letterSpacing: 2.0,
        ),
      ),
      icon: Icon(Icons.arrow_drop_down_circle),
      iconSize: 27.0,
      iconEnabledColor: Colors.white,
      iconDisabledColor: Colors.grey,
      elevation: 15,
      style: TextStyle(
        color: Colors.black,
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
      itemHeight: kMinInteractiveDimension,
      underline: Container(
        height: 2,
        width: 100,
        color: Colors.amberAccent,
      ),
      isDense: false,
      isExpanded: false,
      focusNode: FocusNode(),
      autofocus: false,
      focusColor: Colors.lightGreen[50],
      onChanged: (String? newValue) {
        setState(() {
          /*.. 1- Assign the selected country name to the drop down list.json ...*/
          dropdownValue = newValue;

        });
      },
      selectedItemBuilder: (context) {
        return [];
      },
      items: categories_names_list.map<DropdownMenuItem<String>>((
          String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
          ),
        );
      }).toList(growable: true),
    );
  }
}