import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProductsImagesGridView extends StatelessWidget {
  final File? imageFile;
  final Image? image;
  final IconData? iconGallery;
  final IconData? iconCamera;
  final IconData? iconRemove;
  final TextEditingController? videoController;
  final Function()? onPressedGallery;
  final Function()? onPressedCamera;
  final Function()? onPressedRemove;
  final bool galleryButtonClicked = false;
  final bool cameraButtonClicked = false;
  final bool removeImageClicked = false;

  ProductsImagesGridView({
    this.imageFile,
    this.image,
    this.iconGallery,
    this.iconCamera,
    this.iconRemove,
    this.videoController,
    this.onPressedGallery,
    this.onPressedCamera,
    this.onPressedRemove,
  });

  //
  Color? baseColor = const Color(0xFFF2F2F2);
  //
  @override
  Widget build(BuildContext context) {
    //This must be when usong inkwell widget
    assert(debugCheckHasMaterial(context));
    //
    return Column(
      children: [
        GridView.count(
          scrollDirection: Axis.vertical,
          reverse: false,
          controller: ScrollController(
            initialScrollOffset: 0,
            keepScrollOffset: true,
            debugLabel: 'userAccount_Grid',
          ),
          primary: false,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
          addSemanticIndexes: true,
          crossAxisCount: 4,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 35.0,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(2.0),
              //height: 70.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              alignment: Alignment.center,
              child: imageFile == null
                  ? Text(
                      'generalUse-noImageSelected'.tr().toString(),
                    )
                  : Image.file(imageFile!),
            ),
            Material(
              shadowColor: Colors.grey,
              elevation: 10.0,
              color:baseColor ,
              borderRadius: BorderRadius.circular(20.0),
              //color: Color.fromRGBO(0, 160, 227, 1), // button color
              child: InkWell(
                splashColor: Color.fromRGBO(248, 177, 1, 1),
                // splash color
                onTap:onPressedRemove,
                // button pressed
                child: Icon(
                  iconRemove,
                  color: Colors.teal,
                  size: 30.0,
                ),
              ),
            ),
            Material(
              shadowColor: Colors.grey,
              elevation: 10.0,
              color: baseColor,
              borderRadius: BorderRadius.circular(20.0),
              //color: Color.fromRGBO(0, 160, 227, 1), // button color
              child: InkWell(
                splashColor: Color.fromRGBO(248, 177, 1, 1),
                // splash color
                onTap:onPressedCamera,
                // button pressed
                child: Icon(
                  iconCamera,
                  color: Colors.teal,
                  size: 30.0,
                ),
              ),
            ),
            Material(
              shadowColor: Colors.grey,
              elevation: 10.0,
              color: baseColor,
              borderRadius: BorderRadius.circular(20.0),
              //color: Color.fromRGBO(0, 160, 227, 1), // button color
              child: InkWell(
                splashColor: Color.fromRGBO(248, 177, 1, 1),
                // splash color
                onTap:onPressedGallery,
                // button pressed
                child: Icon(
                  iconGallery,
                  color: Colors.teal,
                  size: 30.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
