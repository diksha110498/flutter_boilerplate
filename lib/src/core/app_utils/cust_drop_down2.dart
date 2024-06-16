import 'package:dropdown_button2/dropdown_button2.dart';

import 'export.dart';

class CustomDropdown2 extends StatelessWidget {
  String? prefixImage;
  String hintText;
  TextEditingController textEditingController;
  List<DropdownMenuItem> items;
  Function(dynamic val) onChangedDropDown;

  CustomDropdown2(this.hintText, this.onChangedDropDown,
      this.textEditingController, this.items,
      {this.prefixImage});

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
        isDense: true,
        underline: Container(
          height: 1.0,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:AppColors.textFieldBorderColor,
                width: 1.0,
              ),
            ),
          ),
        ),

        customButton: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.smallPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible:prefixImage!=null && (prefixImage?.isNotEmpty ?? false),
                child: Image.asset(prefixImage??'',
                    height: AppSizes.smallIconSize,
                    width: AppSizes.smallIconWidthSize),
              ),
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSizes.microPadding),
                  child: Text(
                      textEditingController.text.isNotEmpty
                          ? textEditingController.text
                          : hintText,
                      maxLines: 1,
                      style: textEditingController.text.isNotEmpty
                          ? AppTheme.lightTheme.inputDecorationTheme.labelStyle
                          : AppTheme.lightTheme.inputDecorationTheme.hintStyle),
                ),
              )),
              Image.asset(
                AppImages.dropDownIcon ?? "",
                height: AppSizes.smallIconSize,
                width: AppSizes.smallIconWidthSize,
              )
            ],
          ),
        ),
        items: items,
        iconStyleData: IconStyleData(
            icon: Image.asset(
          AppImages.dropDownIcon ?? "",
              height: AppSizes.smallIconSize,
              width: AppSizes.smallIconWidthSize,
        )),
        // icon: SizedBox(),
        isExpanded: true,
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: AppSizes.getWidth(context, percent: 80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          offset: const Offset(0, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        hint: Text(
            textEditingController.text.isNotEmpty
                ? textEditingController.text
                : hintText,
            maxLines: 1,
            style: textEditingController.text.isNotEmpty
                ? AppTheme.lightTheme.inputDecorationTheme.labelStyle
                : AppTheme.lightTheme.inputDecorationTheme.hintStyle),
        onChanged: onChangedDropDown ?? null);
  }
}
