import '../../../src/core/app_utils/export.dart';

class CommonRegistrationHeader extends StatelessWidget {
  const CommonRegistrationHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundScreen(AppSizes.getHeight(context, percent: 45),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.mediumPadding,
              vertical: AppSizes.xxLPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(AppImages.appLogoMain,
                  width: AppSizes.bigIconWidthSize,
                  height: AppSizes.bigIconSize),
              SizedBox(height: AppSizes.smallvGapSize),
              _headingName(),
              _subHeadingName(),
            ],
          ),
        ));
  }
  _headingName() {
    return RichText(
        text: TextSpan(children: [
          TextSpan(
              text: AppStrings.appName.toUpperCase(),
              style: AppFontStyle.getHeadingStyle(
                  color: Colors.white, fontSize: AppSizes.titleExtraLargeSize)),
          TextSpan(
              text: ' ',
              style: AppFontStyle.getHeadingStyle(
                  color: Colors.white, fontSize: AppSizes.titleExtraLargeSize)),
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(0.0, -20.0),
              child: Text(AppStrings.tradeMarkString,
                  style:
                  AppFontStyle.getContentSmallTextStyle(color: Colors.white)),
            ),
          ),
        ]));
  }

  _subHeadingName() {
    return Text(AppStrings.areYouSureWantToProceedString,
        style: AppFontStyle.getContentLargeTextStyle(color: AppColors.lightTextColor));
  }
}
