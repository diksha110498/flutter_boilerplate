import 'export.dart';

class AppFontStyle {
  static TextStyle getHeadingStyle({
    Color? color,
    double? fontSize,
    TextDecoration? decoration=TextDecoration.none,
  }) =>
      AppTheme.lightTheme.textTheme.titleLarge!.copyWith(
        decoration: decoration ?? TextDecoration.none,
        shadows: [
          Shadow(
              color:
              color ?? AppTheme.lightTheme.textTheme.titleLarge!.color!,
              offset: decoration != TextDecoration.none
                  ? Offset(0, -1)
                  : Offset(0, 0))
        ],
        color: decoration != TextDecoration.none
            ? Colors.transparent
            : color ?? AppTheme.lightTheme.textTheme.titleLarge!.color,
        decorationColor:
            decoration != TextDecoration.none ? color : Colors.transparent,
        decorationThickness: decoration != TextDecoration.none ? 1 : 0,
        decorationStyle: TextDecorationStyle.solid,
        fontSize:
            fontSize ?? AppTheme.lightTheme.textTheme.titleLarge!.fontSize,
      );

  static TextStyle getSubHeadingStyle({
    Color? color,
    TextDecoration? decoration=TextDecoration.none,
  }) =>
      AppTheme.lightTheme.textTheme.titleMedium!.copyWith(
        decoration: decoration ?? TextDecoration.none,
        shadows: [
          Shadow(
              color:
              color ?? AppTheme.lightTheme.textTheme.titleMedium!.color!,
              offset: decoration != TextDecoration.none
                  ? Offset(0, -1)
                  : Offset(0, 0))
        ],
        color: decoration != TextDecoration.none
            ? Colors.transparent
            : color ?? AppTheme.lightTheme.textTheme.titleMedium!.color,
        decorationColor:
            decoration != TextDecoration.none ? color : Colors.transparent,
        decorationThickness: decoration != TextDecoration.none ? 1 : 0,
        decorationStyle: TextDecorationStyle.solid,
        fontSize: AppTheme.lightTheme.textTheme.titleMedium!.fontSize,
      );

  static TextStyle getSmallHeadingStyle({
    Color? color,
    TextDecoration? decoration=TextDecoration.none,
  }) =>
      AppTheme.lightTheme.textTheme.titleSmall!.copyWith(
        decoration: decoration ?? TextDecoration.none,
        shadows: [
          Shadow(
              color:
              color ?? AppTheme.lightTheme.textTheme.titleSmall!.color!,
              offset: decoration != TextDecoration.none
                  ? Offset(0, -1)
                  : Offset(0, 0))
        ],
        color: decoration != TextDecoration.none
            ? Colors.transparent
            : color ?? AppTheme.lightTheme.textTheme.titleSmall!.color,
        decorationColor:
            decoration != TextDecoration.none ? color : Colors.transparent,
        decorationThickness: decoration != TextDecoration.none ? 1 : 0,
        decorationStyle: TextDecorationStyle.solid,
        fontSize: AppTheme.lightTheme.textTheme.titleSmall!.fontSize,
      );

  static TextStyle getExtraSmallHeadingStyle({
    Color? color,
    TextDecoration? decoration=TextDecoration.none,
  }) =>
      AppTheme.lightTheme.textTheme.titleSmall!.copyWith(
        decoration: decoration ?? TextDecoration.none,
        shadows: [
          Shadow(
              color:
              color ?? AppTheme.lightTheme.textTheme.titleSmall!.color!,
              offset: decoration != TextDecoration.none
                  ? Offset(0, -1)
                  : Offset(0, 0))
        ],
        color: decoration != TextDecoration.none
            ? Colors.transparent
            : color ?? AppTheme.lightTheme.textTheme.titleSmall!.color,
        decorationColor:
            decoration != TextDecoration.none ? color : Colors.transparent,
        decorationThickness: decoration != TextDecoration.none ? 1 : 0,
        decorationStyle: TextDecorationStyle.solid,
        fontSize: AppSizes.titleExtraSmallSize,
      );

  static TextStyle getContentLargeTextStyle({
    Color? color,
    TextDecoration? decoration=TextDecoration.none,
  }) =>
      AppTheme.lightTheme.textTheme.bodyLarge!.copyWith(
        decoration: decoration ?? TextDecoration.none,
        shadows: [
          Shadow(
              color:
              color ?? AppTheme.lightTheme.textTheme.bodyLarge!.color!,
              offset: decoration != TextDecoration.none
                  ? Offset(0, -1)
                  : Offset(0, 0))
        ],
        color: decoration != TextDecoration.none
            ? Colors.transparent
            : color ?? AppTheme.lightTheme.textTheme.bodyLarge!.color,
        decorationColor:
            decoration != TextDecoration.none ? color : Colors.transparent,
        decorationThickness: decoration != TextDecoration.none ? 1 : 0,
        decorationStyle: TextDecorationStyle.solid,
        fontSize: AppTheme.lightTheme.textTheme.bodyLarge!.fontSize,
      );

  static TextStyle getContentMediumTextStyle({
    Color? color,
    TextDecoration? decoration=TextDecoration.none,
  }) =>
      AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(
          decoration: decoration ?? TextDecoration.none,
          shadows: [
            Shadow(
                color:
                color ?? AppTheme.lightTheme.textTheme.bodyMedium!.color!,
                offset: decoration != TextDecoration.none
                    ? Offset(0, -2)
                    : Offset(0, 0))
          ],
          color: decoration != TextDecoration.none
              ? Colors.transparent
              : color ?? AppTheme.lightTheme.textTheme.bodyMedium!.color,
          decorationColor:
              decoration != TextDecoration.none ? color : Colors.transparent,
          decorationThickness: decoration != TextDecoration.none ? 1 : 0,
          decorationStyle: TextDecorationStyle.solid,
          fontSize: AppTheme.lightTheme.textTheme.bodyMedium!.fontSize);

  static TextStyle getContentSmallTextStyle({
    Color? color,
    TextDecoration? decoration=TextDecoration.none,
  }) =>
      AppTheme.lightTheme.textTheme.bodySmall!.copyWith(
          decoration: decoration ?? TextDecoration.none,
          shadows: [
            Shadow(
                color:
                color ?? AppTheme.lightTheme.textTheme.bodySmall!.color!,
                offset: decoration != TextDecoration.none
                    ? Offset(0, -1)
                    : Offset(0, 0))
          ],
          color: decoration != TextDecoration.none
              ? Colors.transparent
              : color ?? AppTheme.lightTheme.textTheme.bodySmall!.color,
          decorationColor:
              decoration != TextDecoration.none ? color : Colors.transparent,
          decorationThickness: decoration != TextDecoration.none ? 1 : 0,
          decorationStyle: TextDecorationStyle.solid,
          fontSize: AppTheme.lightTheme.textTheme.bodySmall!.fontSize);

  static TextStyle getContentExtraSmallTextStyle({
    Color? color,
    TextDecoration? decoration=TextDecoration.none,
  }) =>
      AppTheme.lightTheme.textTheme.bodySmall!.copyWith(
          decoration: decoration ?? TextDecoration.none,
          shadows: [
            Shadow(
                color:
                color ?? AppTheme.lightTheme.textTheme.bodySmall!.color!,
                offset: decoration != TextDecoration.none
                    ? Offset(0, -1)
                    : Offset(0, 0))
          ],
          color: decoration != TextDecoration.none
              ? Colors.transparent
              : color ?? AppTheme.lightTheme.textTheme.bodySmall!.color,
          decorationColor:
              decoration != TextDecoration.none ? color : Colors.transparent,
          decorationThickness: decoration != TextDecoration.none ? 1 : 0,
          decorationStyle: TextDecorationStyle.solid,
          fontSize: AppSizes.bodyExtraSmallSize);
}
