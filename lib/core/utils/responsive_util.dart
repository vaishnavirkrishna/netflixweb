import 'package:flutter/material.dart';
class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1100;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double sidebarWidth(BuildContext context) {
    if (isMobile(context)) return 0;
    if (isTablet(context)) return 180;
    return 220;
  }

  // Bigger cards on desktop
  static double cardWidth(BuildContext context) {
    if (isMobile(context)) return 120;
    if (isTablet(context)) return 160;
    return 210;   
  }

  static double cardHeight(BuildContext context) =>
      cardWidth(context) * 1.5;
  static int searchGridColumns(BuildContext context) {
    if (isMobile(context)) return 2;
    if (isTablet(context)) return 4;
    return 6;   
  }
}