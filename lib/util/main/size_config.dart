import 'package:flutter/widgets.dart';
import 'dimensions.dart';

class SizeConfig {
  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _blockSizeHorizontal = 0;
  static double _blockSizeVertical = 0;

  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;
  static double widthMultiplier = 0;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  static DeviceScreenType deviceType = DeviceScreenType.mobile;

  SizeConfig.init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    textMultiplier = _blockSizeVertical;
    imageSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;
    widthMultiplier = _blockSizeHorizontal;

    deviceType = DeviceScreenType.mobile;
    if (_screenWidth > 950) {
      deviceType = DeviceScreenType.desktop;
    } else if (_screenWidth > 650) {
      deviceType = DeviceScreenType.tablet;
    }
    Dimensions.init();
  }

  static valueResponseBuilder(
      {required var onMobile, required var onTablet, required var onDesktop}) {
    if (deviceType == DeviceScreenType.mobile) {
      return onMobile;
    } else if (deviceType == DeviceScreenType.desktop) {
      return onDesktop;
    } else {
      return onTablet;
    }
  }
}

enum DeviceScreenType { mobile, tablet, desktop }
