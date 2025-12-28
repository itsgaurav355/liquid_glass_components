import 'package:flutter/material.dart';

/// Theme configuration for liquid glass components
class LiquidGlassTheme {
  /// Base color for glass effect (usually white or light color)
  final Color baseColor;

  /// Opacity of the glass background (0.0 to 1.0)
  final double opacity;

  /// Blur intensity for the glass effect
  final double blurIntensity;

  /// Border radius for components
  final double borderRadius;

  /// Border width
  final double borderWidth;

  /// Border color
  final Color borderColor;

  /// Shadow color
  final Color shadowColor;

  /// Shadow blur radius
  final double shadowBlur;

  /// Shadow offset
  final Offset shadowOffset;

  /// Text color
  final Color textColor;

  /// Hint text color
  final Color hintColor;

  /// Focus border color
  final Color focusColor;

  /// Error color
  final Color errorColor;

  /// Background gradient colors for liquid effect
  final List<Color>? gradientColors;

  /// Gradient stops
  final List<double>? gradientStops;

  const LiquidGlassTheme({
    this.baseColor = Colors.white,
    this.opacity = 0.2,
    this.blurIntensity = 10.0,
    this.borderRadius = 12.0,
    this.borderWidth = 1.0,
    this.borderColor = Colors.white,
    this.shadowColor = Colors.black26,
    this.shadowBlur = 10.0,
    this.shadowOffset = const Offset(0, 4),
    this.textColor = Colors.white,
    this.hintColor = Colors.white70,
    this.focusColor = Colors.blueAccent,
    this.errorColor = Colors.redAccent,
    this.gradientColors,
    this.gradientStops,
  });

  /// Default light theme
  static const LiquidGlassTheme light = LiquidGlassTheme(
    baseColor: Colors.white,
    opacity: 0.25,
    blurIntensity: 15.0,
    borderRadius: 16.0,
    borderWidth: 1.5,
    borderColor: Colors.white,
    shadowColor: Colors.black12,
    shadowBlur: 20.0,
    shadowOffset: Offset(0, 8),
    textColor: Colors.black87,
    hintColor: Colors.black54,
    focusColor: Colors.blue,
    errorColor: Colors.red,
  );

  /// Default dark theme
  static const LiquidGlassTheme dark = LiquidGlassTheme(
    baseColor: Colors.white,
    opacity: 0.15,
    blurIntensity: 20.0,
    borderRadius: 16.0,
    borderWidth: 1.5,
    borderColor: Colors.white30,
    shadowColor: Colors.black38,
    shadowBlur: 25.0,
    shadowOffset: Offset(0, 10),
    textColor: Colors.white,
    hintColor: Colors.white70,
    focusColor: Colors.blueAccent,
    errorColor: Colors.redAccent,
  );

  /// Create a copy with modified properties
  LiquidGlassTheme copyWith({
    Color? baseColor,
    double? opacity,
    double? blurIntensity,
    double? borderRadius,
    double? borderWidth,
    Color? borderColor,
    Color? shadowColor,
    double? shadowBlur,
    Offset? shadowOffset,
    Color? textColor,
    Color? hintColor,
    Color? focusColor,
    Color? errorColor,
    List<Color>? gradientColors,
    List<double>? gradientStops,
  }) {
    return LiquidGlassTheme(
      baseColor: baseColor ?? this.baseColor,
      opacity: opacity ?? this.opacity,
      blurIntensity: blurIntensity ?? this.blurIntensity,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      borderColor: borderColor ?? this.borderColor,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowBlur: shadowBlur ?? this.shadowBlur,
      shadowOffset: shadowOffset ?? this.shadowOffset,
      textColor: textColor ?? this.textColor,
      hintColor: hintColor ?? this.hintColor,
      focusColor: focusColor ?? this.focusColor,
      errorColor: errorColor ?? this.errorColor,
      gradientColors: gradientColors ?? this.gradientColors,
      gradientStops: gradientStops ?? this.gradientStops,
    );
  }
}
