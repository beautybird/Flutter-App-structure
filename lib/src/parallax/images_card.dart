
import 'package:flutter/material.dart';
import 'package:flutterapp/src/parallax/card_provider.dart';
import 'package:flutterapp/src/parallax/flow_deligate.dart';
import 'package:flutterapp/src/parallax/media_assets.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:provider/provider.dart';

class ImagesCard extends StatefulWidget {
  static const routeName = "/imagesScreenRoute";
  final SettingsController? controller;

  const ImagesCard({super.key, this.controller});

  @override
  State<ImagesCard> createState() => _ImagesCardState();
}

class _ImagesCardState extends State<ImagesCard> {
  CardProvider? cardProvider;

  GlobalKey? _imageKey;

  bool? isSelected;

  @override
  void initState() {
    // TODO: implement initState
    _imageKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    cardProvider = Provider.of<CardProvider>(context);
    //
    isSelected = cardProvider!.isSelected;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: isSelected!
          ? const EdgeInsets.symmetric(vertical: 1, horizontal: 4)
          : const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 6),
            blurRadius: 8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Flow(
          delegate: ParallaxFlowDelegate(
            scrollable: Scrollable.of(context),
            listItemContext: context,
            backgroundImageKey: _imageKey!,
          ),
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image(
                key: _imageKey,
                image: AssetImage(imageAsset()!,),
              ),
            ),
          ],
        ),
      ),
    );
    //return Image.asset(imageAsset()!, fit: BoxFit.fill,);
  }

  String? currentAsset;
  String? imageAsset() {
    if (cardProvider!.mediaIndex != 0) {
      currentAsset = cardProvider!.assetPath;
    } else {
      currentAsset = MediaAssets.images[0];
    }
    return currentAsset;
  }
}
