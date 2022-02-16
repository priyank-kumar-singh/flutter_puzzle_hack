import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ThemeConstants {
  static const lightThemePrimaryColor = Color(0xFF0B4AAA);
  static const lightThemeSecondaryColor = Color(0xFFF0EFEF);

  static const errorColor = Colors.redAccent;
  static const snackBarActionColor = Colors.purple;

  static TextStyle get headline1 {
    return _baseTextStyle.copyWith(
      fontSize: 74,
      fontWeight: FontWeight.bold,
    );
  }

  /// Headline 2 text style
  static TextStyle get headline2 {
    return _baseTextStyle.copyWith(
      fontSize: 54,
      height: 1.1,
      fontWeight: FontWeight.bold,
    );
  }

  /// Headline 3 text style
  static TextStyle get headline3 {
    return _baseTextStyle.copyWith(
      fontSize: 34,
      height: 1.12,
      fontWeight: FontWeight.bold,
    );
  }

  /// Headline 3 Soft text style
  static TextStyle get headline3Soft {
    return _baseTextStyle.copyWith(
      fontSize: 34,
      height: 1.17,
      fontWeight: FontWeight.w400,
    );
  }

  /// Headline 4 text style
  static TextStyle get headline4 {
    return _baseTextStyle.copyWith(
      fontSize: 24,
      height: 1.15,
      fontWeight: FontWeight.bold,
    );
  }

  /// Headline 4 Soft text style
  static TextStyle get headline4Soft {
    return _baseTextStyle.copyWith(
      fontSize: 24,
      height: 1.15,
      fontWeight: FontWeight.w400,
    );
  }

  /// Headline 5 text style
  static TextStyle get headline5 {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.bold,
    );
  }

  /// Body Large Bold text style
  static TextStyle get bodyLargeBold {
    return _baseTextStyle.copyWith(
      fontSize: 46,
      height: 1.17,
      fontWeight: FontWeight.bold,
    );
  }

  /// Body Large text style
  static TextStyle get bodyLarge {
    return _baseTextStyle.copyWith(
      fontSize: 46,
      height: 1.17,
      fontWeight: FontWeight.w400,
    );
  }

  /// Body text style
  static TextStyle get body {
    return _bodyTextStyle.copyWith(
      fontSize: 24,
      height: 1.33,
      fontWeight: FontWeight.w400,
    );
  }

  /// Body Small text style
  static TextStyle get bodySmall {
    return _bodyTextStyle.copyWith(
      fontSize: 18,
      height: 1.22,
      fontWeight: FontWeight.w400,
    );
  }

  /// Body XSmall text style
  static TextStyle get bodyXSmall {
    return _bodyTextStyle.copyWith(
      fontSize: 14,
      height: 1.27,
      fontWeight: FontWeight.w400,
    );
  }

  /// Label text style
  static TextStyle get label {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      height: 1.27,
      fontWeight: FontWeight.w400,
    );
  }

  /// Countdown text style
  static TextStyle get countdownTime {
    return _baseTextStyle.copyWith(
      fontSize: 300,
      height: 1,
      fontWeight: FontWeight.bold,
    );
  }

  static const _baseTextStyle = TextStyle(
    fontFamily: 'GoogleSans',
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  static final _bodyTextStyle = GoogleFonts.roboto(
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  /// Primary 1
  static const Color primary1 = Color(0xFF041E3C);

  /// Primary 2
  static const Color primary2 = Color(0xFF042B59);

  /// Primary 3
  static const Color primary3 = Color(0xFF043875);

  /// Primary 4
  static const Color primary4 = Color(0xFF0553B1);

  /// Primary 5
  static const Color primary5 = Color(0xFF0468D7);

  /// Primary 6
  static const Color primary6 = Color(0xFF027DFD);

  /// Primary 7
  static const Color primary7 = Color(0xFF13B9FD);

  /// Primary 8
  static const Color primary8 = Color(0xFFB8EAFE);

  /// Primary 9
  static const Color primary9 = Color(0xFFE7F8FF);

  /// Primary 0
  static const Color primary0 = Color(0xFFFFFFFF);

  /// Black
  static const Color black = Color(0xFF000000);

  /// Black 2 (opacity 20%)
  static const Color black2 = Color(0x33000000);

  /// Grey 1
  static const Color grey1 = Color(0xFF4A4A4A);

  /// Grey 2
  static const Color grey2 = Color(0xFFA4A4A4);

  /// Grey 3
  static const Color grey3 = Color(0xFFE8EAED);

  /// Grey 4
  static const Color grey4 = Color(0xFFF1F3F4);

  /// Grey 5
  static const Color grey5 = Color(0xFFF8F9FA);

  /// White
  static const Color white = Color(0xFFFFFFFF);

  /// White 2 (opacity 40%)
  static const Color white2 = Color(0x66FFFFFF);

  /// Green primary
  static const Color greenPrimary = Color(0xFF00504C);

  /// Green 90
  static const Color green90 = Color(0xFF71F7EF);

  /// Green 50
  static const Color green50 = Color(0xFF00857F);

  /// Blue primary
  static const Color bluePrimary = Color(0xFF003064);

  /// Blue 90
  static const Color blue90 = Color(0xFF75BFFF);

  /// Blue 50
  static const Color blue50 = Color(0xFF027DFD);

  /// Yellow primary
  static const Color yellowPrimary = Color(0xFF676000);

  /// Yellow 90
  static const Color yellow90 = Color(0xFFFFF475);

  /// Yellow 50
  static const Color yellow50 = Color(0xFF9E9400);
}
