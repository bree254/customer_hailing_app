import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'package:customer_hailing/theme/app_text_styles.dart';
import '../theme/theme_helper.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.obscuringCharacter,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.validator,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final String? obscuringCharacter;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final String? labelText;

  final TextStyle? hintStyle;

  final TextStyle? labelStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: controller,
          focusNode: focusNode ?? FocusNode(),
          autofocus: autofocus!,
          style: textStyle ?? AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w400),
          obscureText: obscureText!,
          obscuringCharacter: obscuringCharacter ?? "*",
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
        ),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? AppTextStyles.bodyRegular,
        labelText: labelText ?? "",
        labelStyle: labelStyle ?? AppTextStyles.inputStyle,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.all(8.h),
        fillColor: fillColor ?? appTheme.grayBlack,
        filled: filled,
        floatingLabelStyle: labelStyle ??
            TextStyle(
              color: appTheme.colorPrimary,
              fontSize: 20.adaptSize,
            ),
    border: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.purple,
            width: 2.0,
          ),
        ),
    enabledBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: primaryColor,
            width: 2.0,
          ),
        ),
    focusedBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: primaryColor,
            width: 2.0,
          ),
        ),
    errorBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: textfieldErrorRedColor,
            width: 2.0,
          ),
        ),
    focusedErrorBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: textfieldErrorRedColor,
            width: 2.0,
          ),
        ),
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static UnderlineInputBorder get underlineInput => UnderlineInputBorder(
        borderSide: BorderSide(color: appTheme.black, width: 1),
      );

  static OutlineInputBorder get fillGray => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide.none,
      );
}
