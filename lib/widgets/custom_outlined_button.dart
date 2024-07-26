import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends BaseButton {
  const CustomOutlinedButton({
    super.key,
    required String buttonText,
    required VoidCallback onPressed,
    super.width,
    super.height,
    this.borderRadius,
    this.fontSize,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
  }) : super(
          text: buttonText,
          onPressed: onPressed,
        );

  final double? borderRadius;
  final double? fontSize;
  final double? borderWidth;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height ?? 42.v,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: buttonColor ?? appTheme.disabledButton,
          side: BorderSide(
            color: borderColor ?? appTheme.colorPrimary,
            width: borderWidth ?? 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 16,
            color: textColor ?? appTheme.colorPrimary,
          ),
        ),
      ),
    );
  }
}
