import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';

/// Utility class for creating glass morphism effects
class GlassEffect {
  /// Creates a glass morphism container decoration
  static BoxDecoration createDecoration({
    required LiquidGlassTheme theme,
    bool isFocused = false,
    bool hasError = false,
    Color? customColor,
  }) {
    final borderColor = hasError
        ? theme.errorColor
        : (isFocused ? theme.focusColor : theme.borderColor);

    return BoxDecoration(
      borderRadius: BorderRadius.circular(theme.borderRadius),
      border: Border.all(
        color: borderColor.withValues(alpha: isFocused ? 0.8 : 0.5),
        width: theme.borderWidth,
      ),
      gradient: theme.gradientColors != null
          ? LinearGradient(
              colors: theme.gradientColors!,
              stops: theme.gradientStops,
            )
          : null,
      boxShadow: [
        BoxShadow(
          color: theme.shadowColor,
          blurRadius: theme.shadowBlur,
          offset: theme.shadowOffset,
        ),
      ],
    );
  }

  /// Creates a glass morphism widget with backdrop filter
  static Widget createGlassWidget({
    required Widget child,
    required LiquidGlassTheme theme,
    bool isFocused = false,
    bool hasError = false,
    Color? customColor,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: createDecoration(
        theme: theme,
        isFocused: isFocused,
        hasError: hasError,
        customColor: customColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(theme.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: theme.blurIntensity,
            sigmaY: theme.blurIntensity,
          ),
          child: Container(
            color: (customColor ?? theme.baseColor).withValues(
              alpha: theme.opacity,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
