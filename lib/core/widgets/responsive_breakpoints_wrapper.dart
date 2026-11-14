import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Wrapper de puntos de quiebre responsivos basado en Codelessly/ResponsiveFramework
Widget responsiveBreakpointsWrapper(BuildContext context, Widget? child) {
  return ResponsiveBreakpoints.builder(
    child: child!,
    breakpoints: const [
      Breakpoint(start: 0, end: 600, name: MOBILE),
      Breakpoint(start: 601, end: 900, name: TABLET),
      Breakpoint(start: 901, end: 1440, name: DESKTOP),
      Breakpoint(start: 1441, end: double.infinity, name: '4K'),
    ],
  );
}

/// Helper universal basado en abuanwar072/Flutter-Responsive-Admin-Panel-or-Dashboard
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 600 &&
      MediaQuery.of(context).size.width <= 900;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 900;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return desktop;
        } else if (constraints.maxWidth > 600 && tablet != null) {
          return tablet!;
        } else if (constraints.maxWidth > 600) {
          return desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}

