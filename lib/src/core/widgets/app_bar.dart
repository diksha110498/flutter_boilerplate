import 'package:flutter_boilerplate/src/core/app_theme/app_colors.dart';

import '../app_utils/export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final double? leadingWidth;
  final double? borderRadius;
  final String? titleText;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool isDividerNeeded;
  final Color? dividerColor;
  final Color? backgroundColor;
  final onLeadingOnTap;

  CustomAppBar(
      {this.backgroundColor = AppColors.primaryColor,
      this.leading,
      this.leadingWidth = 0.0,
      this.borderRadius = 20.0,
      this.title,
      this.titleText,
      this.centerTitle = false,
      this.isDividerNeeded = false,
      this.onLeadingOnTap,
      this.dividerColor,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  !isDividerNeeded ? borderRadius ?? 20.0 : 0.0)),
          backgroundColor: isDividerNeeded ? Colors.white : backgroundColor,
          elevation: 0.0,
          titleSpacing: 0.0,
          leadingWidth: leadingWidth,
          leading: leading ??
              InkWell(
                  onTap: () {
                    if (onLeadingOnTap != null) {
                      onLeadingOnTap();
                    } else {
                      NavigationService.goBack();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Image.asset(AppImages.backArrowIcon,
                        color: isDividerNeeded ? Colors.black : Colors.white,
                        height: AppSizes.extrasmallIconSize,
                        width: AppSizes.extrasmallIconSize),
                  )),
          actions: actions ?? [],
          title: title ??
              Text(titleText ?? "",
                  style: AppFontStyle.getSubHeadingStyle(
                    color: isDividerNeeded
                        ? AppColors.inputTextColor
                        : Colors.white,
                  )),
          centerTitle: centerTitle,
        ),
        isDividerNeeded
            ? Divider(color: dividerColor ?? AppColors.subHeadingColor,
        thickness: 0.5)
            : SizedBox()
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20);
}
