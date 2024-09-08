

import 'package:flutter/material.dart';

class VisibilityStandard extends StatelessWidget {
  //const VisibilityStandard({Key? key}) : super(key: key);

  Widget? child;
  bool? visible;

  VisibilityStandard({this.child, this.visible});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible!,
        child: child!,
    );
  }
}
