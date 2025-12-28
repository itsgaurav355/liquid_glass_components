import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import 'liquid_glass_container.dart';

/// A button with liquid glass morphism effect
class LiquidGlassButton extends StatefulWidget {
  /// Button text
  final String? text;

  /// Child widget (overrides text)
  final Widget? child;

  /// On pressed callback
  final VoidCallback? onPressed;

  /// Theme configuration
  final LiquidGlassTheme? theme;

  /// Button type
  final LiquidGlassButtonType type;

  /// Whether the button is enabled
  final bool enabled;

  /// Padding
  final EdgeInsetsGeometry? padding;

  /// Width
  final double? width;

  /// Height
  final double? height;

  /// Icon to display before text
  final Widget? icon;

  /// Icon to display after text
  final Widget? trailingIcon;

  /// Whether to show loading indicator
  final bool isLoading;

  /// Loading indicator widget
  final Widget? loadingIndicator;

  /// Border radius override
  final double? borderRadius;

  /// Custom background color
  final Color? backgroundColor;

  /// Custom text color
  final Color? textColor;

  const LiquidGlassButton({
    super.key,
    this.text,
    this.child,
    this.onPressed,
    this.theme,
    this.type = LiquidGlassButtonType.primary,
    this.enabled = true,
    this.padding,
    this.width,
    this.height,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.loadingIndicator,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<LiquidGlassButton> createState() => _LiquidGlassButtonState();
}

class _LiquidGlassButtonState extends State<LiquidGlassButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = widget.theme ?? LiquidGlassTheme.light;
    final isEnabled =
        widget.enabled && !widget.isLoading && widget.onPressed != null;

    Color buttonColor;
    Color borderColor;
    double opacity;

    switch (widget.type) {
      case LiquidGlassButtonType.primary:
        buttonColor = widget.backgroundColor ?? effectiveTheme.focusColor;
        borderColor = effectiveTheme.focusColor;
        opacity = _isPressed
            ? effectiveTheme.opacity + 0.2
            : effectiveTheme.opacity + 0.1;
        break;
      case LiquidGlassButtonType.secondary:
        buttonColor = widget.backgroundColor ?? effectiveTheme.baseColor;
        borderColor = effectiveTheme.borderColor;
        opacity = _isPressed
            ? effectiveTheme.opacity + 0.1
            : effectiveTheme.opacity;
        break;
      case LiquidGlassButtonType.danger:
        buttonColor = widget.backgroundColor ?? effectiveTheme.errorColor;
        borderColor = effectiveTheme.errorColor;
        opacity = _isPressed
            ? effectiveTheme.opacity + 0.2
            : effectiveTheme.opacity + 0.1;
        break;
    }

    if (!isEnabled) {
      opacity = opacity * 0.5;
    }

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled
          ? (_) {
              setState(() => _isPressed = false);
              widget.onPressed?.call();
            }
          : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      child: LiquidGlassContainer(
        theme: effectiveTheme.copyWith(
          baseColor: buttonColor,
          borderColor: borderColor,
          opacity: opacity,
          borderRadius: widget.borderRadius ?? effectiveTheme.borderRadius,
        ),
        width: widget.width,
        height: widget.height ?? 50,
        padding:
            widget.padding ??
            const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: widget.isLoading
            ? (widget.loadingIndicator ??
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.textColor ?? effectiveTheme.textColor,
                      ),
                    ),
                  ))
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    widget.icon!,
                    const SizedBox(width: 8),
                  ],
                  widget.child ??
                      Text(
                        widget.text ?? '',
                        style: TextStyle(
                          color: isEnabled
                              ? (widget.textColor ?? effectiveTheme.textColor)
                              : (widget.textColor ?? effectiveTheme.textColor)
                                    .withValues(alpha: 0.5),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  if (widget.trailingIcon != null) ...[
                    const SizedBox(width: 8),
                    widget.trailingIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}

/// Button type enum for [LiquidGlassButton].
///
/// Defines the visual style and behavior of the button:
/// - [primary]: Main action button with focus color background
/// - [secondary]: Secondary action button with base color background
/// - [danger]: Destructive action button with error color background
enum LiquidGlassButtonType {
  /// Primary button style - used for main actions
  primary,

  /// Secondary button style - used for secondary actions
  secondary,

  /// Danger button style - used for destructive actions
  danger,
}
