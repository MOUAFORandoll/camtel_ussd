import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

final screenSize = Get.size;
final designSize = 414.0;
double proportion = screenSize.width / designSize;
// final proportion = designSize / screenSize.width;
final kMarginTop = screenSize.height * .08;
final kMarginBottom = screenSize.height * .08;
final kMarginLeft = screenSize.width * .08;
final kMarginRight = screenSize.width * .08;
final kMarginX = screenSize.width * 0.065;
final kMarginY = screenSize.height * 0.01;

final kPaddingTop = screenSize.height * .08;
final kPaddingBottom = screenSize.height * .08;
final kPaddingLeft = screenSize.width * .08;
final kPaddingRight = screenSize.width * .08;
final kPaddingX = screenSize.width * .08;
final kPaddingY = screenSize.height * .08;

final kSmHeight = screenSize.height * .07;
final kSmWidth = screenSize.width * .5;

final kMdHeight = screenSize.height * 1.3;
final kMdWidth = screenSize.width * .4;

final kHeight = screenSize.height;
final kWidth = screenSize.width;

// final kSSmText = 8* proportion;
// final kSmText = 12.0 * proportion;
// final kMdText = 14.0 * proportion;
final kMediumText = 16.0 * proportion;


final kSSmText = kMediumText;
final kSmText = kMediumText;
final kMdText = kMediumText;


final kLg1Text = 20.0* proportion;
final kLgText = 21.0 * proportion;
final kLg0Text = 25.0 * proportion;
final kXlText = 31.0 * proportion;

final kSmIcon = 28.0;
final kMdIcon = 30.0;
final kLgIcon = 32.0;
final kXlIcon = 34.0;
