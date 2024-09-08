import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SupplierListTile extends StatelessWidget {
  final bool? switchValue;
  final Color? switchActiveColor;
  final Color? switchActiveTrackerColor;
  final Color? switchInActiveThumbColor;
  final Color? switchInActiveTrackerColor;
  final bool? autofocus;
  final Function(bool)? onChanged;
  final String? textDetails;
  final double? fontSize;
  final String? fontFamily;

  SupplierListTile(
      {this.switchValue,
        this.switchActiveColor,
        this.switchActiveTrackerColor,
        this.switchInActiveThumbColor,
        this.switchInActiveTrackerColor,
        this.autofocus,
        this.onChanged,
        this.textDetails,
        this.fontSize,
        this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Switch(
        value: switchValue!,
        activeColor: switchActiveColor,
        activeTrackColor: switchActiveTrackerColor,
        inactiveThumbColor: switchInActiveThumbColor,
        inactiveTrackColor: switchInActiveTrackerColor,
        dragStartBehavior: DragStartBehavior.start,
        focusColor: null,
        hoverColor: null,
        focusNode: FocusNode(),
        autofocus: true,
        onChanged: onChanged!,
        mouseCursor: MouseCursor.defer,
      ),
      title: Text(
        textDetails!,
        textAlign: TextAlign.left,
        softWrap: true,
        style: TextStyle(
          color: Colors.indigo,
          backgroundColor: Colors.transparent,
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
