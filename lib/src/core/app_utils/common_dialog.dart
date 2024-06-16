import 'export.dart';

class DialogUtils {

  static commonDialog(context, child,{isDismissible}) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return child;
      },
      barrierDismissible:isDismissible?? true,
      barrierLabel: MaterialLocalizations
          .of(context)
          .modalBarrierDismissLabel,
       barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  static logoutDialog(context, onTap) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return  AlertDialog(
            elevation: 0.0,
            contentPadding: EdgeInsets.all(AppSizes.largePadding),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(AppSizes.defaultRoundedRadius)),
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  NavigationService.goBack();
                },
                child: Icon(Icons.close, color: AppColors.inputTextColor),
              ),
            ),
            CircleAvatar(
              maxRadius: 50.0,
              minRadius: 50.0,
              backgroundColor: AppColors.secondaryLightColor,
              child: Padding(
                padding: EdgeInsets.all(AppSizes.extralargePadding),
                child: Center(child: Image.asset(AppImages.appLogoMain)),
              ),
            ),
            SizedBox(height: AppSizes.mediumvGapSize),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: AppStrings.areYouSureYouWantTO,
                      style: AppFontStyle.getContentLargeTextStyle()),
                  TextSpan(
                      text: AppStrings.logoutString,
                      style: AppFontStyle.getSubHeadingStyle()),
                ])),
            SizedBox(height: AppSizes.smallvGapSize),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.xxLPadding,
                  vertical: AppSizes.largePadding),
              child: CustomButton(AppStrings.logoutString, () {
                onTap();
              }, AppColors.buttonColor),
            )
          ],
        ));
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  static commonImageOpenDialog(BuildContext context, String image) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Dialog(
          backgroundColor: Colors.white, // Background color set to white
          elevation: 8.0, // Medium elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                AppSizes.defaultRoundedRadius), // Adjusted border radius
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.defaultRoundedRadius),
            // Adjusted border radius
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height *
                      0.5, // Height as per dialog height
                  child: InteractiveViewer(
                    // Interactive viewer for network image
                    child: AppUtils.getNetWorkImage(
                      image,
                      height: MediaQuery.of(context).size.height *
                          0.6, // Height as per dialog height
                      width: MediaQuery.of(context).size.width *
                          0.8, // Width as per dialog width
                      boxFit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: InkWell(
                        child:
                            Icon(Icons.close, color: Colors.black, size: 15.0),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}
