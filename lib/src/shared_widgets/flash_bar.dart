import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutterapp/src/shared_widgets/buttons.dart';

//https://www.youtube.com/watch?v=H-XEIkUfN4M

class ShowFlushBar extends StatelessWidget {

  const ShowFlushBar({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardElevatedButton(
      autofocus: false,
      buttonMinWidth: double.maxFinite,
      buttonMaxWidth: double.maxFinite,
      buttonMinHeight: 150.0,
      buttonMaxHeight: 150.0,
      backgroundBaseColor: Colors.transparent,
      foregroundBaseColor: Colors.white,
      buttonShape:
      WidgetStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
      elevation: 15.0,
      padding: 3.0,
      shadowColor: Colors.grey,
      onHover: (value) {},
      onFocusChanged: (value) {},
      onPressed: () async{
        return await Flushbar(
          message: '',
        );
      },
    );
  }
}
