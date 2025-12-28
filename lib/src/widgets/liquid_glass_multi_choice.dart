import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import 'liquid_glass_container.dart';

/// A multi-choice/checkbox group with liquid glass morphism effect
class LiquidGlassMultiChoice<T> extends StatelessWidget {
  /// List of choice options
  final List<LiquidGlassMultiChoiceOption<T>> options;

  /// Selected values
  final List<T> values;

  /// On changed callback
  final ValueChanged<List<T>>? onChanged;

  /// Theme configuration
  final LiquidGlassTheme? theme;

  /// Whether the field is enabled
  final bool enabled;

  /// Layout direction (horizontal or vertical)
  final Axis direction;

  /// Spacing between options
  final double spacing;

  /// Whether to wrap options
  final bool wrap;

  /// Alignment of options
  final MainAxisAlignment alignment;

  /// Cross axis alignment
  final CrossAxisAlignment crossAxisAlignment;

  const LiquidGlassMultiChoice({
    super.key,
    required this.options,
    required this.values,
    this.onChanged,
    this.theme,
    this.enabled = true,
    this.direction = Axis.vertical,
    this.spacing = 12.0,
    this.wrap = false,
    this.alignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  void _toggleOption(T value) {
    if (!enabled) return;

    final newValues = List<T>.from(values);
    if (newValues.contains(value)) {
      newValues.remove(value);
    } else {
      newValues.add(value);
    }
    onChanged?.call(newValues);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? LiquidGlassTheme.light;

    Widget choiceList = direction == Axis.vertical
        ? Column(
            mainAxisAlignment: alignment,
            crossAxisAlignment: crossAxisAlignment,
            children: _buildOptions(effectiveTheme),
          )
        : Row(
            mainAxisAlignment: alignment,
            crossAxisAlignment: crossAxisAlignment,
            children: _buildOptions(effectiveTheme),
          );

    if (wrap) {
      choiceList = Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: _buildOptions(effectiveTheme),
      );
    }

    return choiceList;
  }

  List<Widget> _buildOptions(LiquidGlassTheme theme) {
    return options.map((option) {
      final isSelected = values.contains(option.value);

      return Padding(
        padding: EdgeInsets.only(
          right: direction == Axis.horizontal ? spacing : 0,
          bottom: direction == Axis.vertical ? spacing : 0,
        ),
        child: _MultiChoiceItem<T>(
          option: option,
          isSelected: isSelected,
          theme: theme,
          enabled: enabled,
          onTap: () => _toggleOption(option.value),
        ),
      );
    }).toList();
  }
}

class _MultiChoiceItem<T> extends StatelessWidget {
  final LiquidGlassMultiChoiceOption<T> option;
  final bool isSelected;
  final LiquidGlassTheme theme;
  final bool enabled;
  final VoidCallback onTap;

  const _MultiChoiceItem({
    required this.option,
    required this.isSelected,
    required this.theme,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: LiquidGlassContainer(
        theme: theme.copyWith(
          borderColor: isSelected ? theme.focusColor : theme.borderColor,
          borderWidth: isSelected ? 2.0 : theme.borderWidth,
          opacity: isSelected ? theme.opacity + 0.1 : theme.opacity,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isSelected ? theme.focusColor : theme.borderColor,
                    width: 2,
                  ),
                  color: isSelected
                      ? theme.focusColor.withValues(alpha: 0.3)
                      : Colors.transparent,
                ),
                child: isSelected
                    ? Icon(Icons.check, size: 16, color: theme.focusColor)
                    : null,
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child:
                      option.child ??
                      Text(
                        option.label,
                        style: TextStyle(
                          color: enabled
                              ? theme.textColor
                              : theme.textColor.withValues(alpha: 0.5),
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Option for [LiquidGlassMultiChoice] widget.
///
/// Represents a single selectable option in a multi-choice group.
/// Each option has a value and a label to display.
///
/// Example:
/// ```dart
/// LiquidGlassMultiChoiceOption<String>(
///   value: 'item1',
///   label: 'Item 1',
/// )
/// ```
class LiquidGlassMultiChoiceOption<T> {
  /// Value of the option
  final T value;

  /// Label to display
  final String label;

  /// Custom child widget (overrides label)
  final Widget? child;

  const LiquidGlassMultiChoiceOption({
    required this.value,
    required this.label,
    this.child,
  });
}
