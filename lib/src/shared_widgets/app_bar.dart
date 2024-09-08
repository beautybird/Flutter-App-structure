import 'package:flutter/material.dart';

class AppBarStandard extends StatelessWidget implements PreferredSizeWidget {
  Widget? leading;
  Widget? title;
  Widget? flexibleSpace;
  List<Widget>? actions;
  Color? backgroundColor;
  PreferredSizeWidget? bottom;
  IconButton? iconButton;

  AppBarStandard({
    this.leading, this.title, this.flexibleSpace, this.actions, this.backgroundColor, this.bottom, this.iconButton}); // could be any widget


  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      automaticallyImplyLeading: true,
      title: title,
      flexibleSpace: flexibleSpace,
      actions: <Widget>[
        /*IconButton(
          icon: Icon(
            Icons.more_vert,
          ),
          iconSize: 25.0,
          alignment: Alignment.center,
          color: Colors.teal,
          highlightColor: Colors.yellow,
          hoverColor: Colors.yellowAccent,
          splashColor: Colors.white,
          disabledColor: Colors.grey,
          padding: EdgeInsets.all(2.0),
          autofocus: false,
          tooltip: 'Start Search',
          enableFeedback: true,
          onPressed: () => moreOptions(),
        ),*/
      ],
      elevation: 10.0,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(
        color: Colors.black,
        opacity: 0.8,
        size: 20.0,
      ),
      //actionsIconTheme: ,
      primary: true,
      centerTitle: true,
      titleSpacing: 5.0,
      //distance between leading and next to it Widget
      toolbarOpacity: 0.8,
      bottomOpacity: 0.8,
      bottom: bottom, /*PreferredSize(
        preferredSize: Size(50.0, 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
              ),
              iconSize: 25.0,
              alignment: Alignment.center,
              color: Colors.teal,
              highlightColor: Colors.yellow,
              hoverColor: Colors.yellowAccent,
              splashColor: Colors.white,
              disabledColor: Colors.grey,
              padding: EdgeInsets.all(2.0),
              autofocus: false,
              tooltip: 'Start Search',
              enableFeedback: true,
              onPressed: () => startSearch(),
            ),
            TextField(),
          ],
        ),
      )*/
      /*shape: ShapeDecoration(
        shape: ,
        color: Colors.white,
        image: ,
        gradient:Gradient(colors: null,stops: ,transform: ,) ,
        shadows ,
      ),*/

    );
  }

  moreOptions() {}

  startSearch() {}

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(50.0, 60.0);
}
