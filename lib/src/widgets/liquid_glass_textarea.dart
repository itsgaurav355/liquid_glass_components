import 'package:flutter/material.dart';
import '../theme/liquid_glass_theme.dart';
import 'liquid_glass_input_text.dart';

/// A textarea/multi-line text input with liquid glass morphism effect
class LiquidGlassTextarea extends StatelessWidget {
  /// Controller for the text field
  final TextEditingController? controller;

  /// Initial value
  final String? initialValue;

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

  /// Whether the field is read-only
  final bool readOnly;

  /// Maximum number of lines
  final int? maxLines;

  /// Minimum number of lines
  final int? minLines;

  /// Maximum length
  final int? maxLength;

  /// On changed callback
  final ValueChanged<String>? onChanged;

  /// Validator function
  final String? Function(String?)? validator;

  /// Autofocus
  final bool autofocus;

  /// Focus node
  final FocusNode? focusNode;

  /// Padding
  final EdgeInsetsGeometry? padding;

  /// Width
  final double? width;

  /// Height
  final double? height;

  const LiquidGlassTextarea({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.theme,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 5,
    this.minLines = 3,
    this.maxLength,
    this.onChanged,
    this.validator,
    this.autofocus = false,
    this.focusNode,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: LiquidGlassInputText(
        controller: controller,
        initialValue: initialValue,
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        errorText: errorText,
        theme: theme,
        enabled: enabled,
        readOnly: readOnly,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        autofocus: autofocus,
        focusNode: focusNode,
        padding: padding ?? const EdgeInsets.all(16),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
