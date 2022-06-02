import 'size_config.dart';

class Dimensions {
  static double xMarginHorizontal = 0;
  static double xMarginVertical = 0;
  static double dashboardItemHeight = 0;
  static double dashboardIconSize = 0;
  static const double maxDashboardItemWidth = 750;
  static const double maxAppWidth = 750;
  static const double maxAppFormWidth = 480;

  static double sMarginVertical = 0;
  static double sMarginHorizontal = 0;

  static double loadingSize = 22;
  static int spanCountProduct = 2;
  static int spanCountResponsiveList = 1;
  static double imageSizeList = 140;
  static double loginMaxWith = 350;

  Dimensions.init() {
    xMarginHorizontal = SizeConfig.widthMultiplier * 4;
    xMarginVertical = SizeConfig.heightMultiplier * 4;
    dashboardItemHeight = SizeConfig.heightMultiplier * 13;

    sMarginVertical = SizeConfig.heightMultiplier * 1;
    sMarginHorizontal = SizeConfig.widthMultiplier * 2;
    if (SizeConfig.deviceType == DeviceScreenType.mobile) {
      spanCountProduct = 2;
      spanCountResponsiveList = 1;
      loadingSize = 22;
      dashboardIconSize = 42;
      imageSizeList = 140;
      loginMaxWith = 350;
    } else if (SizeConfig.deviceType == DeviceScreenType.tablet) {
      spanCountProduct = 3;
      spanCountResponsiveList = 2;
      loadingSize = 28;
      dashboardIconSize = 50;
      imageSizeList = 150;
      loginMaxWith = 450;
    } else if (SizeConfig.deviceType == DeviceScreenType.desktop) {
      spanCountProduct = 6;
      spanCountResponsiveList = 3;
      loadingSize = 32;
      dashboardIconSize = 55;
      imageSizeList = 155;
      loginMaxWith = 450;
    }
  }
}
