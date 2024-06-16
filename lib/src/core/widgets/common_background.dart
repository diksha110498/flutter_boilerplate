import '../app_utils/export.dart';

class CommonBackgroundScreen extends StatelessWidget {
  final double height;
  final Color bgColor;
  final Widget child;
  final double? borderRadius;

  const CommonBackgroundScreen(this.height,
      {super.key,
      this.bgColor = AppColors.primaryColor,
      this.child = const SizedBox(),
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: AppSizes.getWidth(context),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
            bottomLeft:
                Radius.circular(borderRadius ?? AppSizes.largeRoundedRadius),
            bottomRight:
                Radius.circular(borderRadius ?? AppSizes.largeRoundedRadius),
          )),
      child: child,
    );
  }
}
