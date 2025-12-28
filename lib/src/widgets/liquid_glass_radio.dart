import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import 'liquid_glass_container.dart';

/// A radio button with liquid glass morphism effect
class LiquidGlassRadio<T> extends StatelessWidget {
  /// Value of this radio button
  final T value;

  /// Selected value of the group
  final T? groupValue;

  /// On changed callback
  final ValueChanged<T?>? onChanged;

  /// Theme configuration
  final LiquidGlassTheme? theme;

  /// Whether the radio is enabled
  final bool enabled;

  /// Label text
  final String? label;

  /// Custom label widget (overrides label)
  final Widget? labelWidget;

  /// Size of the radio button
  final double size;

  /// Spacing between radio and label
  final double spacing;

  const LiquidGlassRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.theme,
    this.enabled = true,
    this.label,
    this.labelWidget,
    this.size = 24.0,
    this.spacing = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? LiquidGlassTheme.light;
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(value) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LiquidGlassContainer(
            theme: effectiveTheme.copyWith(
              borderColor: isSelected
                  ? effectiveTheme.focusColor
                  : effectiveTheme.borderColor,
              borderWidth: isSelected ? 2.0 : effectiveTheme.borderWidth,
              opacity: isSelected
                  ? effectiveTheme.opacity + 0.1
                  : effectiveTheme.opacity,
              borderRadius: size / 2,
            ),
            width: size,
            height: size,
            padding: EdgeInsets.zero,
            child: isSelected
                ? Center(
                    child: Container(
                      width: size * 0.4,
                      height: size * 0.4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: effectiveTheme.focusColor,
                      ),
                    ),
                  )
                : null,
          ),
          if (label != null || labelWidget != null) ...[
            SizedBox(width: spacing),
            labelWidget ??
                Text(
                  label!,
                  style: TextStyle(
                    color: enabled
                        ? effectiveTheme.textColor
                        : effectiveTheme.textColor.withValues(alpha: 0.5),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}
