import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ListViewHome extends StatelessWidget {
  final Axis? scroll;
  final ScrollPhysics? physics;
  final bool? shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final int? semanticChildes;
  final String? restorationId;
  final Clip? clipBehaviour;
  final List<Widget>? widgets;

  ListViewHome({
    this.scroll,
    this.physics,
    this.shrinkWrap,
    this.padding,
    this.semanticChildes,
    this.restorationId,
    this.clipBehaviour,
    this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: key,
      scrollDirection: scroll!,
      controller: ScrollController(
        initialScrollOffset: 0,
        keepScrollOffset: true,
        debugLabel: 'listViewStandard',
      ),
      primary: false,
      physics: physics,
      shrinkWrap: shrinkWrap!,
      padding: padding,
      itemExtent: 0.0,
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      addSemanticIndexes: true,
      cacheExtent: 0.0,
      semanticChildCount: semanticChildes,
      dragStartBehavior: DragStartBehavior.start,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      restorationId: restorationId,
      clipBehavior: clipBehaviour!,
      children: widgets!,
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  final Axis? scrollDirection;
  final double? verticalPadding;
  final double? horizontalPadding;
  final int? listItemsCount;
  final Widget? child;

  const ListViewBuilder(
      {Key? key,
      this.scrollDirection,
      this.verticalPadding,
      this.horizontalPadding,
      this.listItemsCount,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: scrollDirection!,
        reverse: false,
        controller: ScrollController(),
        primary: false,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding!,
          horizontal: horizontalPadding!,
        ),
        itemCount: listItemsCount,
        semanticChildCount: 0,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        clipBehavior: Clip.hardEdge,
        itemBuilder: (BuildContext context, int index) {
          return child!;
        });
  }
}
