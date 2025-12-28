import 'package:flutter/material.dart';
import 'dart:ui';
import '../theme/liquid_glass_theme.dart';
import '../utils/glass_effect.dart';

/// A container widget with liquid glass morphism effect
class LiquidGlassContainer extends StatelessWidget {
  /// Child widget
  final Widget? child;

  /// Theme configuration
  final LiquidGlassTheme? theme;

  /// Width of the container
  final double? width;

  /// Height of the container
  final double? height;

  /// Padding inside the container
  final EdgeInsetsGeometry? padding;

  /// Margin around the container
  final EdgeInsetsGeometry? margin;

  /// Alignment of the child
  final AlignmentGeometry? alignment;

  /// Custom background color override
  final Color? backgroundColor;

  /// Custom border color override
  final Color? borderColor;

  /// Custom border radius override
  final double? borderRadius;

  /// Custom opacity override
  final double? opacity;

  /// Custom blur intensity override
  final double? blurIntensity;

  /// Gradient colors for liquid effect
  final List<Color>? gradientColors;

  /// Gradient stops
  final List<double>? gradientStops;

  /// Box constraints
  final BoxConstraints? constraints;

  /// Clip behavior
  final Clip clipBehavior;

  const LiquidGlassContainer({
    super.key,
    this.child,
    this.theme,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.alignment,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.opacity,
    this.blurIntensity,
    this.gradientColors,
    this.gradientStops,
    this.constraints,
    this.clipBehavior = Clip.antiAlias,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? LiquidGlassTheme.light;

    final customTheme = effectiveTheme.copyWith(
      baseColor: backgroundColor ?? effectiveTheme.baseColor,
      borderColor: borderColor ?? effectiveTheme.borderColor,
      borderRadius: borderRadius ?? effectiveTheme.borderRadius,
      opacity: opacity ?? effectiveTheme.opacity,
      blurIntensity: blurIntensity ?? effectiveTheme.blurIntensity,
      gradientColors: gradientColors ?? effectiveTheme.gradientColors,
      gradientStops: gradientStops ?? effectiveTheme.gradientStops,
    );

    Widget container = Container(
      width: width,
      height: height,
      margin: margin,
      constraints: constraints,
      padding: padding,
      alignment: alignment,
      decoration: GlassEffect.createDecoration(theme: customTheme),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(customTheme.borderRadius),
        clipBehavior: clipBehavior,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: customTheme.blurIntensity,
            sigmaY: customTheme.blurIntensity,
          ),
          child: Container(
            color: customTheme.baseColor.withValues(alpha: customTheme.opacity),
            child: child,
          ),
        ),
      ),
    );

    return container;
  }
}
