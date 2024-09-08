/*

class TwinkleButtonStandard extends StatelessWidget {
  final String? twinkleText;
  final Color? twinkleTextColor;
  final double? twinkleTextSize;
  final FontStyle? twinkleFontStyle;
  final FontWeight? twinkleFontWeight;
  final TextAlign? twinkleTextAlign;
  final Color? twinkleColor;
  final Color? twinkleHighlighColor;
  final double? twinkleHeight;
  final double? twinkleWidth;
  final int? twinkleTime;
  final Color? btnColor;
  final Function()? onClick;

  TwinkleButtonStandard(
      {this.twinkleText,
      this.twinkleTextColor,
      this.twinkleTextSize,
      this.twinkleFontStyle,
      this.twinkleFontWeight,
      this.twinkleTextAlign,
      this.twinkleColor,
      this.twinkleHighlighColor,
      this.twinkleHeight,
      this.twinkleWidth,
      this.twinkleTime,
        this.btnColor,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return TwinkleButton(
      buttonTitle: Text(
        twinkleText!,
        textAlign: twinkleTextAlign,
        style: TextStyle(
          fontSize: twinkleTextSize,
          color: twinkleTextColor,
          fontStyle: twinkleFontStyle,
          fontWeight: twinkleFontWeight,
        ),
      ),
      buttonColor: btnColor,
      onclickButtonFunction: onClick,
    );
  }
}
*/

/*

class TwinklePromotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TwinkleButton(
      buttonTitle: Text(
        'Promo',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      buttonColor: Colors.orange,
      twinkleTime: 100,
      buttonWidth: 80,
      buttonHeight: 40,
      onclickButtonFunction: () {
        // Open the promotion page
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              'This Week Promotion',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            titlePadding: EdgeInsets.all(5.0),
            content: Stack(
              children: [
                Positioned(
                  child: Text(
                    'Come on to our big sale of all types of cheese',
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    maxLines: 10,
                    semanticsLabel: 'Big Sale',
                    style: TextStyle(),
                  ),
                ),
                Positioned(
                  // child: Image.memory(''),
                  child: Image.asset(
                    'res/bigSale.jpg',
                    semanticLabel: 'Big Sale',
                    scale: 2.0,
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    repeat: ImageRepeat.noRepeat,
                  ),
                ),
              ],
            ),
            actions: [],
          ),
          barrierDismissible: true,
          barrierColor: Colors.lightBlue,
        );
      },
    );
  }
}
*/


/*
class TwinkleAddPageToFavorite extends StatelessWidget {
  final Function onClick;


  TwinkleAddPageToFavorite({this.onClick});

  @override
  Widget build(BuildContext context) {
    return TwinkleButton(
      buttonTitle: Text(
        'Ask Shop',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
      buttonColor: Colors.orange,
      twinkleTime: 100,
      buttonWidth: 110,
      buttonHeight: 40,
      onclickButtonFunction: onClick,
    );
  }
}*/

