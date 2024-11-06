import 'package:customer_hailing/theme/theme_helper.dart';
import 'package:flutter/material.dart';

import '../core/app_export.dart';

class AppTextStyles {
  //AppBar textstyles
  static get largeAppBarText => theme.textTheme.bodyLarge!.copyWith(
    fontSize: 16,fontWeight: FontWeight.w600,color: searchtextGrey
  );
  static get mediumAppBarText => theme.textTheme.bodyLarge!.copyWith(
      fontSize: 14,fontWeight: FontWeight.w500,color: searchtextGrey
  );
  static get mediumBoldAppBarText => theme.textTheme.bodyLarge!.copyWith(
      fontSize: 14,fontWeight: FontWeight.w600,color: searchtextGrey
  );

  static get onBoardingAppBarText => theme.textTheme.bodyLarge!.copyWith(
      fontSize: 20,fontWeight: FontWeight.w600,color: blackTextColor
  );

  // Textfield textstyles
  static get titleTextField => theme.textTheme.bodyLarge!.copyWith(
      fontSize: 14, fontWeight: FontWeight.w400, color: formTextLabelColor
  );
  static get resendCodeText => theme.textTheme.bodyMedium!.copyWith(
      color: resendCodeTextColor, fontWeight: FontWeight.w400, fontSize: 14
  );
  static get invalidOtpText => theme.textTheme.bodySmall!.copyWith(
      color: textfieldErrorRedColor, fontWeight: FontWeight.w400, fontSize: 12
  );
  static get resendCodeLink => theme.textTheme.bodyMedium!.copyWith(
      color: resendCodeTextColor, decoration: TextDecoration.underline,
      fontWeight: FontWeight.w400, fontSize: 14
  );
  static get textFieldLabel => theme.textTheme.bodyMedium!.copyWith(
      color: formTextLabelColor, fontWeight: FontWeight.w400, fontSize: 14
  );
  static get textFieldHint => theme.textTheme.bodyMedium!.copyWith(
      color: blackTextColor, fontWeight: FontWeight.w400, fontSize: 14
  );

  // list tile text styles
  static get listTileTitle => theme.textTheme.bodyLarge!.copyWith(
      fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xFF555555)
  );

  static get listTileSubtitle => theme.textTheme.bodyMedium!.copyWith(
      color: const Color(0xFF9CA3AF), fontSize: 12, fontWeight: FontWeight.w400
  );

  static get listTileTrailing => theme.textTheme.bodyMedium!.copyWith(
      color: primaryColor, fontSize: 12, fontWeight: FontWeight.w400
  );

  static get rebookButtonText => theme.textTheme.bodySmall!.copyWith(
      color: const Color(0xFF1F2A37), fontSize: 10, fontFamily: 'BR Omny',
      fontWeight: FontWeight.w400, height: 0.20, letterSpacing: 0.25
  );

// CustomElevatedButton text styles
  static get customButtonText => theme.textTheme.headlineSmall!.copyWith(
      color: appTheme.white, fontSize: 16, fontWeight: FontWeight.w600
  );

  // Forgot Password text style
  static get forgotPasswordText => theme.textTheme.bodySmall!.copyWith(
      color: primaryColor, fontWeight: FontWeight.w600, fontSize: 12
  );

  // "or" text style
  static get orText => theme.textTheme.bodySmall!.copyWith(
      color: formTextLabelColor, fontWeight: FontWeight.w400, fontSize: 12
  );

  // Standardized text styles for font size 14
  static get text14Black400 => theme.textTheme.bodyMedium!.copyWith(
      color: blackTextColor, fontWeight: FontWeight.w400, fontSize: 14
  );
  static get text14Black500 => theme.textTheme.bodyMedium!.copyWith(
      color: blackTextColor, fontWeight: FontWeight.w500, fontSize: 14
  );
  static get text14Black600 => theme.textTheme.bodyMedium!.copyWith(
      color: blackTextColor, fontWeight: FontWeight.w600, fontSize: 14
  );
  static get text14Resend400 => theme.textTheme.bodyMedium!.copyWith(
      color: resendCodeTextColor, fontWeight: FontWeight.w400, fontSize: 14
  );
  static get text14Error400 => theme.textTheme.bodyMedium!.copyWith(
      color: textfieldErrorRedColor, fontWeight: FontWeight.w400, fontSize: 14
  );
  static get text14FormLabel400 => theme.textTheme.bodyMedium!.copyWith(
      color: formTextLabelColor, fontWeight: FontWeight.w400, fontSize: 14
  );


  static get backButtonText => theme.textTheme.bodySmall!.copyWith(
    color: primaryColor,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );

//Body fontstyles
  static get bodyLarger => theme.textTheme.bodyLarge!.copyWith(
        fontSize: 18,
      );
  static get bodyHeading => theme.textTheme.bodyLarge!.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static get bodyMedium => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      );

  static get bodyRegular => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 14.0,
        color: disabledButtonGrey,
        fontWeight: FontWeight.w400,
      );

  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: primaryColor,
      );
  static get bodySmall => theme.textTheme.bodySmall!.copyWith(
    fontSize: 12.0,
    color:disabledButtonGrey,
    fontWeight: FontWeight.w400,
  );
  static get bodySmallBold => theme.textTheme.bodySmall!.copyWith(
    fontSize: 12.0,
    color:formTextLabelColor,
    fontWeight: FontWeight.w500,
  );

  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
    fontSize: 12.0,
    color: primaryColor,
    fontWeight: FontWeight.w600,
  );

  static get bodyLarge => theme.textTheme.bodyLarge!.copyWith(
    fontSize: 18.0,
    color: formTextLabelColor,
    fontWeight: FontWeight.w500,
  );
// headline texts
  static get headlineSmallSemiBold => theme.textTheme.headlineSmall!.copyWith(
    fontSize: 24,
  );



  static get normalStyle => theme.textTheme.bodyMedium!.copyWith(
        color: const Color(0XFF000000),
        fontSize: 18,
      );

  static get inputStyle => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.grayBlack,
        fontSize: 14,
      );
  static get labelStyle => theme.textTheme.labelMedium!.copyWith(
    color: appTheme.grayText,
    fontSize: 14,
  );

  static get titleStyle => theme.textTheme.labelMedium!
      .copyWith(color: appTheme.grayText, fontSize: 20, fontWeight: FontWeight.w600);

  // Headline text style
  static get headlineSmall => theme.textTheme.headlineSmall!.copyWith(
        color: Colors.white,
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
//changed font to 12
  static get titleMedium => theme.textTheme.titleMedium!.omny
      .copyWith(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12);

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
      fontFamily: 'BrOmny',
    );
  }
}
