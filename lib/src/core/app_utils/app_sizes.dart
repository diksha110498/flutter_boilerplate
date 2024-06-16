import 'export.dart';
class AppSizes {

  //font sizes
  static late final titleLargeSize = 22.0.sp;
  static late final titleExtraLargeSize = 40.0.sp;
  static late final titleMeidumSize = 16.0.sp;
  static late final titleSmallSize = 13.0.sp;
  static late final titleExtraSmallSize = 10.0.sp;

  static late final bodyLargeSize = 15.0.sp;
  static late final bodyMediumSize = 13.0.sp;
  static late final bodySmallSize = 12.0.sp;
  static late final bodyExtraSmallSize = 10.0.sp;

  static late final buttonTextSize = 15.0.sp;

  static late final microPadding = 5.0.r;
  static late final extraMicro2Padding = 1.0.sp;
  static late final extraMicroPadding = 3.0.r;
  static late final extraSmallPadding = 7.0.r;
  static late final smallPadding = 10.0.r;
  static late final mediumPadding = 15.0.r;
  static late final largePadding = 20.0.r;
  static late final extralargePadding = 25.0.r;
  static late final xxLPadding = 30.r;
  static late final xxxLPadding = 40.r;
  static late final xxxxLPadding = 50.r;

  static late final buttonHeight = 200.0.h;
  static late final microMargin = 5.0.r;
  static late final smallMargin = 10.0.r;
  static late final mediumMargin = 15.0.r;
  static late final largeMargin = 20.0.r;
  static late final extralargeMargin = 25.0.r;

  static late final extraSmallRoundedRadius = 5.0.r;
  static late final microSmallRoundedRadius = 7.0.r;
  static late final smallRoundedRadius = 10.0.r;
  static late final mediumRoundedRadius = 10.0.r;
  static late final defaultRoundedRadius = 20.0.r;
  static late final largeRoundedRadius = 25.0.r;
  static late final extraLargeRoundedRadius = 200.0.r;

  static late final buttonHeightSize = 51.0.h;
  static late final minButtonWidthSize = 0.3.sw;

  static late final extrasmallIconSize = 10.0.h;
  static late final smallIconSize = 15.0.h;
  static late final mediumIconSize = 20.0.h;
  static late final largeIconSize = 25.0.h;
  static late final etxraLargeIconSize = 25.0.h;
  static late final xLargeIconSize = 30.0.h;
  static late final xxLIconSize = 40.0.h;
  static late final xxxLIconSize = 50.0.h;
  static late final xxxxLIconSize = 60.0.h;
  static late final bigIconSize = 80.0.h;
  static late final extraBigIconSize = 100.0.h;

  static late final microIconWidthSize = 7.0.w;
  static late final extrasmallIconWidthSize = 10.0.w;
  static late final smallIconWidthSize = 15.0.w;
  static late final mediumIconWidthSize = 20.0.w;
  static late final largeIconWidthSize = 25.0.w;
  static late final etxraLargeIconWidthSize = 25.0.w;
  static late final xLargeIconWidthSize = 30.0.w;
  static late final xxLIconWidthSize = 40.0.w;
  static late final xxxLIconWidthSize = 50.0.w;
  static late final xxxxLIconWidthSize = 60.0.w;
  static late final bigIconWidthSize = 80.0.w;
  static late final extraBigIconWidthSize = 100.0.w;
  static late final xextraBigIconWidthSize = 120.0.w;


  static late final extraMicrovDoubleGapSize = 1.0.h;
  static late final extraMicrovGapSize = 3.0.h;
  static late final extraSmallvGapSize = 5.0.h;
  static late final smallvGapSize = 10.0.h;
  static late final mediumvGapSize = 15.0.h;
  static late final largevGapSize = 20.0.h;
  static late final extraLargevGapSize = 30.0.h;

  static late final xmicrohGapSize = 1.0.w;
  static late final microhGapSize = 3.0.w;
  static late final extraSmallhGapSize = 5.0.w;
  static late final smallhGapSize = 10.0.w;
  static late final mediumhGapSize = 15.0.w;
  static late final largehGapSize = 20.0.w;
  static late final extraLargehGapSize = 30.0.w;


  static late final extraSmallHeightSize = 15.0.h;
  static late final smallHeightSize = 20.0.h;
  static late final mediumHeightSize = 30.0.h;
  static late final extraMediumHeightSize = 35.0.h;
  static late final largeHeightSize = 50.0.h;

  static late final extraSmallWidthSize = 15.0.w;
  static late final smallWidthSize = 20.0.w;
  static late final mediumWidthSize = 30.0.w;
  static late final extraMediumWidthSize = 35.0.w;
  static late final largeWidthSize = 50.0.w;





  static  double getWidth(BuildContext context, {double percent = 100}) =>
      percent / 100 * MediaQuery.of(context).size.width;

  static double getHeight(BuildContext context, {double percent = 100}) =>
      percent / 100 * MediaQuery.of(context).size.height;
}
