import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';

import '../core/app_export.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      this.alignment,
      this.width,
      this.height,
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
      this.outerLabelText,
      this.hintStyle,
      this.labelStyle,
      this.outerLabelStyle,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.borderDecoration,
      this.boxDecoration,
      this.fillColor,
      this.filled = false,
      this.validator,
      this.margin,
      this.maxLength});

  final Alignment? alignment;

  final double? width;
  final double? height;

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

  final String? outerLabelText;

  final TextStyle? hintStyle;

  final TextStyle? labelStyle;

  final TextStyle? outerLabelStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final EdgeInsets? margin;

  final BoxDecoration? boxDecoration;

  final int? maxLength;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode? _focusNode;
  bool _isFocused = false;
  bool _isNotEmpty = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode!.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_focusNode?.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode!.hasFocus;
      });
    }
  }

  void _handleTextChange() {
    setState(() {
      _isNotEmpty = widget.controller?.text.isNotEmpty ?? false;
    });
  }

  @override
  void dispose() {
    _focusNode?.removeListener(_handleFocusChange);
    widget.controller?.removeListener(_handleTextChange);
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => Container(
        width: widget.width ?? double.maxFinite,
        margin: widget.margin ?? EdgeInsets.zero,
        height: widget.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.outerLabelText != null)
              Text(
                widget.outerLabelText!,
                style: widget.outerLabelStyle ?? AppTextStyles.labelStyle,
              ),
            if (widget.outerLabelText != null)
              SizedBox(
                height: 8.v,
              ),
            TextFormField(
              scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              controller: widget.controller,
              focusNode: _focusNode ?? FocusNode(),
              autofocus: widget.autofocus!,
              style: widget.textStyle ??
                  AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w400),
              obscureText: widget.obscureText!,
              obscuringCharacter: widget.obscuringCharacter ?? "*",
              textInputAction: widget.textInputAction,
              keyboardType: widget.textInputType,
              maxLines: widget.maxLines ?? 1,
              decoration: decoration,
              validator: (value) {
                if (_isNotEmpty) {
                  return null;
                }
                return widget.validator?.call(value);
              },
              maxLength: widget.maxLength,
            ),
          ],
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: widget.hintText ?? "",
        hintStyle: widget.hintStyle ?? AppTextStyles.bodyRegular,
        labelText: widget.labelText ?? "",
        labelStyle: widget.labelStyle ?? AppTextStyles.inputStyle,
        prefixIcon: widget.prefix,
        prefixIconConstraints: widget.prefixConstraints,
        suffixIcon: widget.suffix,
        suffixIconConstraints: widget.suffixConstraints,
        isDense: true,
        counterText: '',
        contentPadding: widget.contentPadding ?? EdgeInsets.all(8.h),
        fillColor: _isFocused ? Colors.white : widget.fillColor ?? appTheme.grayBlack,
        filled: widget.filled,
        floatingLabelStyle: widget.labelStyle ??
            TextStyle(
              color: appTheme.colorPrimary,
              fontSize: 20.adaptSize,
            ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
        enabledBorder: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.h),
          borderSide: BorderSide(
              color: _isNotEmpty ? appTheme.inputError : appTheme.colorPrimary,
              width: 1), // Change color based on text field content
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: textfieldErrorRedColor,
            width: 1.0,
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
