import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:image/image.dart' as image;
import 'package:flutterapp/src/shared_widgets/grid_image.dart';

class ImagesGrid extends StatefulWidget {
  static const routeName = "/imagesGridRoute";
  final SettingsController? controller;

  const ImagesGrid({Key? key, this.controller}) : super(key: key);

  @override
  State<ImagesGrid> createState() => _ImagesGridState();
}

class _ImagesGridState extends State<ImagesGrid> {
  // Add images of the real estate
  File? _image1File;

  //This is the source of the Image
  String? image1FromCamera;

  String? image1FromGallery;

  String? image1;

  Uint8List? image1Bytes;

  image.Image? prod1Image;

  XFile? image1PickedFile;

  String? encodedImage1;

  Future<String?>? _getImage1FromCamera(var image1File) async {
    try {
      image1PickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 60,
          preferredCameraDevice: CameraDevice.rear);
      image1Bytes = await image1PickedFile!.readAsBytes();

      encodedImage1 = base64Encode(image1Bytes!);

      if (image1Bytes!.lengthInBytes > 0) {
        image1FromCamera = encodedImage1;
        setState(() => _image1File = File(image1PickedFile!.path));
      } else {
        image1FromCamera = null;
        setState(() => _image1File = File(''));
      }
    } catch (err) {
      image1FromCamera = null;
      setState(() => _image1File = File(''));
      err.toString();
    }
    return image1FromCamera!;
  }

  Future<String?>? _getImage1FromGallery(var image1File) async {
    try {
      image1PickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 60,
          preferredCameraDevice: CameraDevice.rear);

      image1Bytes = await image1PickedFile!.readAsBytes();

      encodedImage1 = base64Encode(image1Bytes!);

      if (image1Bytes!.lengthInBytes > 0) {
        image1FromGallery = encodedImage1;
        setState(() => _image1File = File(image1PickedFile!.path));
      } else {
        image1FromGallery = null;
        setState(() => _image1File = File(''));
      }
    } catch (err) {
      image1FromGallery = null;
      setState(() => _image1File = File(''));
      err.toString();
    }
    return image1FromGallery!;
  }

  ///This to set the no product image in case seller add less than 10 products
  String? noImage;
  String? noProductImageBase64;

  Future<String> getNoImageData() async {
    print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    /*await rootBundle.load('res/noproduct.png')
        .then((noProductImage) {
          //var asUint64List = noProductImage.buffer.asUint64List(0,noProductImage.lengthInBytes);
          noImage = base64Encode(noProductImage.buffer.asUint64List(0,noProductImage.lengthInBytes));
          var noImageBase64String = getNoImageBase64String(noImage);
          print('noImage length is ${noImage.length}');
    })
        .catchError((err){
          err.toString();
    })
        .whenComplete(() => null);*/

    ByteData bytes = await rootBundle.load('assets/images/noproduct.png');
    noImage = base64Encode(bytes.buffer.asUint8List(0, bytes.lengthInBytes));
    var noImageBase64String = getNoImageBase64String(noImage!);
    return noImage!;
  }

  String getNoImageBase64String(String noImageBase64String) {
    noProductImageBase64 = noImageBase64String;
    return noProductImageBase64!;
  }

  Future removeItemImage1(File? imageFile) async {
       _image1File = null;
       setState(() {
         Timer(Duration(seconds: 1),(){
           _image1File = File('assets/images/noproduct.png');
         });
       });
  }

  @override
  void initState() {
    // TODO: implement initState

    //Initialize the No Product Image
    var noImageData = getNoImageData();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: double.maxFinite,
        maxWidth: double.maxFinite,
        minHeight: 100.0,
        maxHeight: 100.0,
      ),
      child: ProductsImagesGridView(
        imageFile: _image1File,
        //image:Image.file(selectedFile(_image)) ,
        iconGallery: Icons.photo,
        iconCamera: Icons.camera,
        iconRemove: Icons.delete,
        onPressedGallery: () =>
            setState(() => _getImage1FromGallery(_image1File)),
        onPressedCamera: () =>
            setState(() => _getImage1FromCamera(_image1File)),
        onPressedRemove: () => setState(() => removeItemImage1(_image1File)),
      ),
    );
  }
}
