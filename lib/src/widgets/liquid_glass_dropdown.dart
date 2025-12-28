import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import '../utils/glass_effect.dart';

/// Item for [LiquidGlassDropdown] widget.
///
/// Represents a single selectable item in a dropdown menu.
/// Each item has a value and a label to display.
///
/// Example:
/// ```dart
/// LiquidGlassDropdownItem<String>(
///   value: 'us',
///   label: 'United States',
/// )
/// ```
class LiquidGlassDropdownItem<T> {
  /// Value of the item
  final T value;

  /// Label to display
  final String label;

  /// Custom child widget (overrides label)
  final Widget? child;

  const LiquidGlassDropdownItem({
    required this.value,
    required this.label,
    this.child,
  });
}

/// A dropdown/select field with liquid glass morphism effect
class LiquidGlassDropdown<T> extends StatefulWidget {
  /// List of items
  final List<LiquidGlassDropdownItem<T>> items;

  /// Selected value
  final T? value;

  /// Hint text
  final String? hintText;

  /// Label text
  final String? labelText;

  /// Helper text
  final String? helperText;

  /// Error text
  final String? errorText;

  /// Theme configuration
  final LiquidGlassTheme? theme;

  /// Whether the field is enabled
  final bool enabled;

  /// On changed callback
  final ValueChanged<T?>? onChanged;

  /// Validator function
  final String? Function(T?)? validator;

  /// Autofocus
  final bool autofocus;

  /// Padding
  final EdgeInsetsGeometry? padding;

  /// Width
  final double? width;

  /// Whether the dropdown is expanded
  final bool isExpanded;

  /// Icon for dropdown
  final Widget? icon;

  /// Icon size
  final double? iconSize;

  /// Menu max height
  final double? menuMaxHeight;

  const LiquidGlassDropdown({
    super.key,
    required this.items,
    this.value,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.theme,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.autofocus = false,
    this.padding,
    this.width,
    this.isExpanded = true,
    this.icon,
    this.iconSize,
    this.menuMaxHeight,
  });

  @override
  State<LiquidGlassDropdown<T>> createState() => _LiquidGlassDropdownState<T>();
}

class _LiquidGlassDropdownState<T> extends State<LiquidGlassDropdown<T>> {
  bool _hasError = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _errorText = widget.errorText;
    _hasError = widget.errorText != null;
  }

  void _validate(T? value) {
    if (widget.validator != null) {
      final error = widget.validator!(value);
      setState(() {
        _hasError = error != null;
        _errorText = error ?? widget.errorText;
      });
    } else if (widget.errorText != null) {
      setState(() {
        _hasError = true;
        _errorText = widget.errorText;
      });
    } else {
      setState(() {
        _hasError = false;
        _errorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = widget.theme ?? LiquidGlassTheme.light;

    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                widget.labelText!,
                style: TextStyle(
                  color: effectiveTheme.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          GlassEffect.createGlassWidget(
            theme: effectiveTheme,
            isFocused: false,
            hasError: _hasError,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: widget.value,
                hint: widget.hintText != null
                    ? Padding(
                        padding:
                            widget.padding ??
                            const EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            widget.hintText!,
                            style: TextStyle(color: effectiveTheme.hintColor),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      )
                    : null,
                selectedItemBuilder: (BuildContext context) {
                  return widget.items.map((item) {
                    return Padding(
                      padding:
                          widget.padding ??
                          const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child:
                            item.child ??
                            Text(
                              item.label,
                              style: TextStyle(color: effectiveTheme.textColor),
                              textAlign: TextAlign.start,
                            ),
                      ),
                    );
                  }).toList();
                },
                isExpanded: widget.isExpanded,
                icon:
                    widget.icon ??
                    Icon(
                      Icons.arrow_drop_down,
                      color: effectiveTheme.textColor,
                      size: widget.iconSize ?? 24,
                    ),
                iconSize: widget.iconSize ?? 24,
                style: TextStyle(color: effectiveTheme.textColor),
                items: widget.items.map((item) {
                  return DropdownMenuItem<T>(
                    value: item.value,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child:
                          item.child ??
                          Text(
                            item.label,
                            style: TextStyle(color: effectiveTheme.textColor),
                            textAlign: TextAlign.start,
                          ),
                    ),
                  );
                }).toList(),
                onChanged: widget.enabled
                    ? (T? newValue) {
                        _validate(newValue);
                        widget.onChanged?.call(newValue);
                      }
                    : null,
                menuMaxHeight: widget.menuMaxHeight,
                dropdownColor: effectiveTheme.baseColor.withValues(alpha: 0.95),
              ),
            ),
          ),
          if (widget.helperText != null && !_hasError)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                widget.helperText!,
                style: TextStyle(color: effectiveTheme.hintColor, fontSize: 12),
              ),
            ),
          if (_errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                _errorText!,
                style: TextStyle(
                  color: effectiveTheme.errorColor,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
