import 'package:flutter/material.dart';

class ListTileStandard extends StatelessWidget {
  Widget? leading;
  Widget? title;
  Widget? subtitle;
  Widget? trailing;
  bool? isThreeLine;
  bool? isSelected;
  bool? isFocused;
  Color? tileColor;
  Color? selectedTileColor;
  Function()? onTap;
  Function()? onLongPressed;

  ListTileStandard(
      {this.leading,
      this.title,
      this.subtitle,
      this.trailing,
      this.isThreeLine,
        this.isSelected,
        this.isFocused,
        this.tileColor,
        this.selectedTileColor,
      this.onTap,
      this.onLongPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      isThreeLine: isThreeLine!,
      dense: true,
      visualDensity: VisualDensity.comfortable,
      shape:const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      contentPadding: EdgeInsets.all(1.0),
      enabled: true,
      mouseCursor: MouseCursor.defer,
      selected: isSelected!,
      focusColor: Colors.white,
      hoverColor: Colors.grey,
      focusNode: FocusNode(),
      autofocus: isFocused!,
      tileColor: tileColor,
      selectedTileColor: selectedTileColor,
      horizontalTitleGap: 1.0,
      minVerticalPadding: 1.0,
      minLeadingWidth: 1.0,
      onTap: onTap,
      onLongPress: onLongPressed,
    );
  }
}
