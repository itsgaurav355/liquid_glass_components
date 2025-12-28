import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import 'liquid_glass_container.dart';

/// A checkbox with liquid glass morphism effect
class LiquidGlassCheckbox extends StatelessWidget {
  /// Whether the checkbox is checked
  final bool? value;

  /// On changed callback
  final ValueChanged<bool?>? onChanged;

  /// Theme configuration
  final LiquidGlassTheme? theme;

  /// Whether the checkbox is enabled
  final bool enabled;

  /// Label text
  final String? label;

  /// Custom label widget (overrides label)
  final Widget? labelWidget;

  /// Size of the checkbox
  final double size;

  /// Spacing between checkbox and label
  final double spacing;

  const LiquidGlassCheckbox({
    super.key,
    required this.value,
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
    final isChecked = value ?? false;

    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(!isChecked) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LiquidGlassContainer(
            theme: effectiveTheme.copyWith(
              borderColor: isChecked
                  ? effectiveTheme.focusColor
                  : effectiveTheme.borderColor,
              borderWidth: isChecked ? 2.0 : effectiveTheme.borderWidth,
              opacity: isChecked
                  ? effectiveTheme.opacity + 0.1
                  : effectiveTheme.opacity,
              borderRadius: 4.0,
            ),
            width: size,
            height: size,
            padding: EdgeInsets.zero,
            child: isChecked
                ? Icon(
                    Icons.check,
                    size: size * 0.7,
                    color: effectiveTheme.focusColor,
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
