import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SwitchStandard extends StatelessWidget {
  final bool? switchValue;
  final Color? switchActiveColor;
  final Color? switchActiveTrackerColor;
  final Color? switchInActiveThumbColor;
  final Color? switchInActiveTrackerColor;
  final bool? autofocus;
  final Function(bool?)? onChanged;
  final String? textDetails;
  final Color? textColor;
  final double? fontSize;
  final String? fontFamily;
  final double? splashRadius;

  const SwitchStandard(
      {Key? key,
      this.switchValue,
      this.switchActiveColor,
      this.switchActiveTrackerColor,
      this.switchInActiveThumbColor,
      this.switchInActiveTrackerColor,
      this.autofocus,
      this.onChanged,
      this.textDetails,
        this.textColor,
      this.fontSize,
      this.fontFamily,
      this.splashRadius})
      : super(key: key);

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
        autofocus: autofocus!,
        onChanged: onChanged!,
        mouseCursor: MouseCursor.defer,
        splashRadius: splashRadius,
      ),
      title: Text(
        textDetails!,
        textAlign: TextAlign.left,
        softWrap: true,
        style: TextStyle(
          color: textColor,
          backgroundColor: Colors.transparent,
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
