import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/liquid_glass_theme.dart';
import 'liquid_glass_input_text.dart';

/// A number input field with liquid glass morphism effect
class LiquidGlassInputNumber extends StatelessWidget {
  /// Controller for the text field
  final TextEditingController? controller;

  /// Initial value
  final num? initialValue;

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

  /// Whether to allow decimal numbers
  final bool allowDecimal;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether the field is read-only
  final bool readOnly;

  /// Minimum value
  final num? min;

  /// Maximum value
  final num? max;

  /// On changed callback
  final ValueChanged<num?>? onChanged;

  /// Validator function
  final String? Function(num?)? validator;

  /// Autofocus
  final bool autofocus;

  /// Focus node
  final FocusNode? focusNode;

  /// Prefix icon
  final Widget? prefixIcon;

  /// Suffix icon
  final Widget? suffixIcon;

  /// Padding
  final EdgeInsetsGeometry? padding;

  /// Width
  final double? width;

  const LiquidGlassInputNumber({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.theme,
    this.allowDecimal = true,
    this.enabled = true,
    this.readOnly = false,
    this.min,
    this.max,
    this.onChanged,
    this.validator,
    this.autofocus = false,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.width,
  });

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    num? number;
    if (allowDecimal) {
      number = double.tryParse(value);
    } else {
      number = int.tryParse(value);
    }

    if (number == null) {
      return 'Please enter a valid number';
    }

    if (min != null && number < min!) {
      return 'Value must be at least $min';
    }

    if (max != null && number > max!) {
      return 'Value must be at most $max';
    }

    if (validator != null) {
      return validator!(number);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LiquidGlassInputText(
      controller: controller,
      initialValue: initialValue?.toString(),
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: errorText,
      theme: theme,
      keyboardType: allowDecimal
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      focusNode: focusNode,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      padding: padding,
      width: width,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          allowDecimal ? RegExp(r'^-?\d*\.?\d*') : RegExp(r'^-?\d*'),
        ),
      ],
      validator: _validateNumber,
      onChanged: (value) {
        if (value.isEmpty) {
          onChanged?.call(null);
          return;
        }

        num? number;
        if (allowDecimal) {
          number = double.tryParse(value);
        } else {
          number = int.tryParse(value);
        }

        onChanged?.call(number);
      },
    );
  }
}
