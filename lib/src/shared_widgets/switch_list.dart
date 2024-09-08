import 'package:flutter/material.dart';
import 'package:flutterapp/src/shared_widgets/container.dart';


class SwitchList extends StatelessWidget {
  final String? switchText;
  final String? switchSubtitle;
  final String? switchActiveThumbImage;
  final String? switchInactiveThumbImage;
  final String? switchSecondaryImage;
  final bool? switchSelectedValue;
  final Function(bool?)? onChanged;

  const SwitchList(
      {Key? key,
      this.switchText,
      this.switchSubtitle,
      this.switchActiveThumbImage,
      this.switchInactiveThumbImage,
      this.switchSecondaryImage,
        this.switchSelectedValue,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerStandard(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      minWidth: 250.0,
      maxWidth: 250.0,
      minHeight: 53.0,
      maxHeight: 53.0,
      color: Colors.grey[100],
      boxBorder: Border.all(
        color: Colors.blue,
        width: 0.5,
        style: BorderStyle.solid,
      ),
      boxBorderRadius: const BorderRadius.all(
        Radius.circular(20.0),
      ),
      child: SwitchListTile(
        title: Text(
          switchText!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        subtitle: Text(
          switchSubtitle!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        tileColor: Colors.blue,
        selectedTileColor: null,
        activeColor: Colors.green,
        activeTrackColor: Colors.lightGreen[100],
        inactiveThumbColor: Colors.yellow,
        inactiveTrackColor: Colors.lightBlue[100],
        activeThumbImage: AssetImage(switchActiveThumbImage!),
        inactiveThumbImage: AssetImage(switchInactiveThumbImage!),
        value: switchSelectedValue!,
        isThreeLine: false,
        dense: false,
        contentPadding: const EdgeInsets.all(1.0),
        selected: false,
        autofocus: false,
        secondary: Image.asset(
          switchSecondaryImage!,
          width: 50.0,
          height: 48.0,
        ),
        visualDensity: const VisualDensity(),
        focusNode: FocusNode(),
        enableFeedback: false,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.red,
            width: 0.5,
            style: BorderStyle.solid,
          ),
        ),
        onChanged: onChanged!,
      ),
    );
  }
}
