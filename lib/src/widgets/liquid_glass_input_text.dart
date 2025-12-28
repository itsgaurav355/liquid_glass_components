import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/liquid_glass_theme.dart';
import '../utils/glass_effect.dart';

/// A text input field with liquid glass morphism effect
class LiquidGlassInputText extends StatefulWidget {
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

  /// Text input type
  final TextInputType? keyboardType;

  /// Whether the field is obscure (for passwords)
  final bool obscureText;

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

  /// Text capitalization
  final TextCapitalization textCapitalization;

  /// Text input action
  final TextInputAction? textInputAction;

  /// On changed callback
  final ValueChanged<String>? onChanged;

  /// On submitted callback
  final ValueChanged<String>? onSubmitted;

  /// On editing complete callback
  final VoidCallback? onEditingComplete;

  /// Validator function
  final String? Function(String?)? validator;

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

  /// Custom decoration
  final InputDecoration? decoration;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  const LiquidGlassInputText({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.theme,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.validator,
    this.autofocus = false,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.width,
    this.decoration,
    this.inputFormatters,
  });

  @override
  State<LiquidGlassInputText> createState() => _LiquidGlassInputTextState();
}

class _LiquidGlassInputTextState extends State<LiquidGlassInputText> {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  bool _isFocused = false;
  bool _hasError = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode.addListener(_onFocusChange);
    _errorText = widget.errorText;
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  String? _validate(String? value) {
    if (widget.validator != null) {
      final error = widget.validator!(value);
      setState(() {
        _hasError = error != null;
        _errorText = error ?? widget.errorText;
      });
      return error;
    }
    if (widget.errorText != null) {
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
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = widget.theme ?? LiquidGlassTheme.light;

    final inputDecoration =
        widget.decoration ??
        InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          helperText: widget.helperText,
          errorText: _errorText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              widget.padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          hintStyle: TextStyle(color: effectiveTheme.hintColor),
          labelStyle: TextStyle(color: effectiveTheme.textColor),
          helperStyle: TextStyle(color: effectiveTheme.hintColor),
          errorStyle: TextStyle(color: effectiveTheme.errorColor),
          counterStyle: TextStyle(color: effectiveTheme.hintColor),
        );

    return SizedBox(
      width: widget.width,
      child: GlassEffect.createGlassWidget(
        theme: effectiveTheme,
        isFocused: _isFocused,
        hasError: _hasError,
        padding: EdgeInsets.zero,
        child: TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          autofocus: widget.autofocus,
          inputFormatters: widget.inputFormatters,
          style: TextStyle(color: effectiveTheme.textColor),
          textAlign: TextAlign.start,
          decoration: inputDecoration,
          onChanged: (value) {
            _validate(value);
            widget.onChanged?.call(value);
          },
          onFieldSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          validator: _validate,
        ),
      ),
    );
  }
}
