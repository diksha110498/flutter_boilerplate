import 'package:flutter/services.dart';

import 'export.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final String? hintText;
  final bool readOnly;
  final bool filled;
  final Color? fillColor;

  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final InputBorder? inputBorder;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? prefixIconConstaints;
  final List<TextInputFormatter>? inputFormatter;
  final onTap;
  final onChanged;
  final onSubmitted;
  final int minLines;
  final int? maxLength;
  final int maxLines;
  final BoxConstraints? suffixIconConstraints;

  CustomTextField(this.textEditingController, this.focusNode, this.hintText,
      {this.textInputType = TextInputType.text,
      this.readOnly = false,
      this.onTap,
      this.fillColor,
      this.filled = false,
      this.textInputAction = TextInputAction.next,
      this.inputBorder,
      this.hintStyle,
      this.onChanged,
      this.onSubmitted,
      this.labelStyle,
      this.suffixIconConstraints,
      this.suffixIcon,
      this.prefixIcon,
      this.inputFormatter,
      this.minLines = 1,
      this.maxLines = 1,
      this.maxLength,
      this.prefixIconConstaints});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      readOnly: readOnly,
      maxLines: maxLines,
      onChanged: onChanged,
      onEditingComplete: onSubmitted,
      clipBehavior: Clip.antiAlias,
      minLines: minLines,
      maxLength: maxLength,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      onTap: onTap ?? () {},

      inputFormatters: inputFormatter ?? [],
      style: labelStyle ?? AppTheme.lightTheme.inputDecorationTheme.labelStyle,
      decoration: InputDecoration(
          hintText: hintText,
          counterText: '',
          fillColor: fillColor ?? Colors.transparent,
          filled:filled,
          contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.smallPadding,vertical: AppSizes.extraSmallPadding),
          border: inputBorder ??
              const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.textFieldBorderColor)),
          focusedErrorBorder: inputBorder ??
              const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.textFieldBorderColor)),
          errorBorder: inputBorder ??
              const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.textFieldBorderColor)),
          focusedBorder: inputBorder ??
              const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.textFieldBorderColor)),
          disabledBorder: inputBorder ??
              const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.textFieldBorderColor)),
          enabledBorder: inputBorder ??
              const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.textFieldBorderColor)),
          prefixIcon: prefixIcon,
          prefixIconConstraints: prefixIconConstaints ??
              BoxConstraints(
                  maxWidth: AppSizes.mediumIconWidthSize,
                  maxHeight: AppSizes.mediumIconSize),
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixIconConstraints ??
              BoxConstraints(
                  maxWidth: AppSizes.largeIconWidthSize,
                  maxHeight: AppSizes.largeIconWidthSize),
          hintStyle:
              hintStyle ?? AppTheme.lightTheme.inputDecorationTheme.hintStyle),
    );
  }
}
