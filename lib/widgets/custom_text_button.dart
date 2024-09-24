import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends BaseButton {
  const CustomTextButton({
    super.key,
    required super.text,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildTextButtonWidget,
          )
        : buildTextButtonWidget;
  }

  Widget get buildTextButtonWidget => Container(
        height: height ?? 42.v,
        width: width ?? double.maxFinite,
        margin: margin,
        child: TextButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Text(
            text,
            style: buttonTextStyle,
          ),
        ),
      );
}
