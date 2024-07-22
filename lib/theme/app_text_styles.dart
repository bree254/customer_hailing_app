import 'package:customer_hailing/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static get bodyLarge => theme.textTheme.bodyLarge!.copyWith(
        fontSize: 16,
      );

  static get bodyMedium => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 16.0,
        color: appTheme.black,
        fontWeight: FontWeight.w500,
      );

  static get bodyRegular => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 14.0,
        color: appTheme.black,
        fontWeight: FontWeight.w400,
      );

  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get normalStyle => theme.textTheme.bodyMedium!.copyWith(
        color: const Color(0XFF000000),
        fontSize: 18,
      );

  static get inputStyle => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.grayBlack,
        fontSize: 14,
      );

  // Headline text style
  static get headlineSmall => theme.textTheme.headlineSmall!.copyWith(
        color: Colors.white,
      );

  static get headlineSmallSemiBold => theme.textTheme.headlineSmall!.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      );

  static get headlineSmallwhite => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.white,
        fontSize: 24,
      );

  static get headlineSmallwhite_1 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.white,
      );

  static get labelLargeMedium => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.grayBlack,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      );

  static get labelLargePrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w500,
      );

  static get labelMedium => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.grayBlack,
        fontSize: 11,
      );

  static get labelMediumOnPrimaryContainer => theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );

  static get labelMediumPrimary => theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );

  static get labelMediumSemiBold => theme.textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );

  // Title text style
  static get titleLargeGray600 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.grayText,
        fontWeight: FontWeight.w600,
      );

  static get titleLargewhite => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.white,
      );

  static get titleMediumBold => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

  static get titleMediumGray600 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.grayText,
        fontSize: 16,
      );

  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 16,
      );

  static get subtitleTextStyle => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );

  static get subtitleLinkStyle => theme.textTheme.titleMedium!.omny.copyWith(
      color: theme.colorScheme.primary,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
      decorationColor: appTheme.colorPrimary);

  static get titleMediumSemiBold => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );

  static get titleMediumwhite => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

  static get titleMedium => theme.textTheme.titleMedium!.omny
      .copyWith(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16);

  static get titleSmall => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.grayBlack,
        fontWeight: FontWeight.w500,
      );

  static get titleSmallMedium => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w500,
      );

  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w500,
      );

  static get buttonText => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.white,
        fontSize: 24,
      );
}

extension on TextStyle {
  TextStyle get omny {
    return copyWith(
      fontFamily: 'br_omny',
    );
  }
}
