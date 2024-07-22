import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';

class AppDecoration {
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: appTheme.colorPrimary,
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder17 => BorderRadius.circular(
        17.h,
      );
  static BorderRadius get circleBorder41 => BorderRadius.circular(
        41.h,
      );

  // Custom borders
  static BorderRadius get customBorderBL10 => BorderRadius.vertical(
        bottom: Radius.circular(10.h),
      );
  static BorderRadius get customBorderLR16 => BorderRadius.horizontal(
        right: Radius.circular(16.h),
      );
  static BorderRadius get customBorderLR5 => BorderRadius.horizontal(
        right: Radius.circular(5.h),
      );
  static BorderRadius get customBorderTL120 => BorderRadius.only(
        topLeft: Radius.circular(120.h),
      );
  static BorderRadius get customBorderTL25 => BorderRadius.vertical(
        top: Radius.circular(25.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder111 => BorderRadius.circular(
        111.h,
      );
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20.h,
      );
  static BorderRadius get roundedBorder25 => BorderRadius.circular(
        25.h,
      );
  static BorderRadius get roundedBorder33 => BorderRadius.circular(
        33.h,
      );
  static BorderRadius get roundedBorder36 => BorderRadius.circular(
        36.h,
      );
  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.h,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;
