import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import 'liquid_glass_container.dart';

/// A single choice/radio button group with liquid glass morphism effect
class LiquidGlassChoice<T> extends StatelessWidget {
  /// List of choice options
  final List<LiquidGlassChoiceOption<T>> options;

  /// Selected value
  final T? value;

  /// On changed callback
  final ValueChanged<T?>? onChanged;

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

  const LiquidGlassChoice({
    super.key,
    required this.options,
    this.value,
    this.onChanged,
    this.theme,
    this.enabled = true,
    this.direction = Axis.vertical,
    this.spacing = 12.0,
    this.wrap = false,
    this.alignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

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
      final isSelected = value == option.value;

      return Padding(
        padding: EdgeInsets.only(
          right: direction == Axis.horizontal ? spacing : 0,
          bottom: direction == Axis.vertical ? spacing : 0,
        ),
        child: _ChoiceItem<T>(
          option: option,
          isSelected: isSelected,
          theme: theme,
          enabled: enabled,
          onTap: () {
            if (enabled) {
              onChanged?.call(isSelected ? null : option.value);
            }
          },
        ),
      );
    }).toList();
  }
}

class _ChoiceItem<T> extends StatelessWidget {
  final LiquidGlassChoiceOption<T> option;
  final bool isSelected;
  final LiquidGlassTheme theme;
  final bool enabled;
  final VoidCallback onTap;

  const _ChoiceItem({
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
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? theme.focusColor : theme.borderColor,
                    width: 2,
                  ),
                  color: isSelected
                      ? theme.focusColor.withValues(alpha: 0.3)
                      : Colors.transparent,
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.focusColor,
                          ),
                        ),
                      )
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

/// Option for choice widget
class LiquidGlassChoiceOption<T> {
  /// Value of the option
  final T value;

  /// Label to display
  final String label;

  /// Custom child widget (overrides label)
  final Widget? child;

  const LiquidGlassChoiceOption({
    required this.value,
    required this.label,
    this.child,
  });
}
