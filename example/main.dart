import 'package:flutter/material.dart';
import 'package:liquid_glass_components/liquid_glass_components.dart';

/// Example usage of Liquid Glass Components
///
/// This example demonstrates all available components in the
/// liquid_glass_components package.
void main() {
  runApp(const ExampleApp());
}

/// Example application showcasing Liquid Glass Components.
///
/// This app displays all available glass morphism components
/// with a beautiful gradient background.
class ExampleApp extends StatelessWidget {
  /// Creates an instance of [ExampleApp].
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquid Glass Components Example',
      theme: ThemeData.dark(),
      home: const ExamplePage(),
    );
  }
}

/// Example page displaying all Liquid Glass Components.
///
/// This page demonstrates the usage of all available components
/// including inputs, dropdowns, choices, buttons, and more.
class ExamplePage extends StatefulWidget {
  /// Creates an instance of [ExamplePage].
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _textareaController = TextEditingController();

  String? _selectedDropdown;
  String? _selectedChoice;
  List<String> _selectedMultiChoice = [];
  bool _checkboxValue = false;
  String? _radioValue;

  @override
  void dispose() {
    _textController.dispose();
    _numberController.dispose();
    _textareaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Custom theme
    const customTheme = LiquidGlassTheme(
      baseColor: Colors.white,
      opacity: 0.2,
      blurIntensity: 15.0,
      borderRadius: 16.0,
      borderWidth: 1.5,
      borderColor: Colors.white,
      textColor: Colors.white,
      hintColor: Colors.white70,
      focusColor: Colors.blueAccent,
      errorColor: Colors.redAccent,
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade900,
              Colors.blue.shade900,
              Colors.cyan.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Liquid Glass Components',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),

                // Container Example
                LiquidGlassContainer(
                  theme: customTheme,
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    'This is a glass container',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

                // Text Input Example
                LiquidGlassInputText(
                  theme: customTheme,
                  controller: _textController,
                  labelText: 'Text Input',
                  hintText: 'Enter your name',
                  prefixIcon: const Icon(Icons.person, color: Colors.white70),
                  onChanged: (value) => debugPrint('Text: $value'),
                ),
                const SizedBox(height: 16),

                // Number Input Example
                LiquidGlassInputNumber(
                  theme: customTheme,
                  controller: _numberController,
                  labelText: 'Number Input',
                  hintText: 'Enter a number',
                  allowDecimal: true,
                  min: 0,
                  max: 100,
                  prefixIcon: const Icon(Icons.numbers, color: Colors.white70),
                  onChanged: (value) => debugPrint('Number: $value'),
                ),
                const SizedBox(height: 16),

                // Textarea Example
                LiquidGlassTextarea(
                  theme: customTheme,
                  controller: _textareaController,
                  labelText: 'Textarea',
                  hintText: 'Enter your message',
                  minLines: 3,
                  maxLines: 5,
                  onChanged: (value) => debugPrint('Textarea: $value'),
                ),
                const SizedBox(height: 16),

                // Dropdown Example
                LiquidGlassDropdown<String>(
                  theme: customTheme,
                  labelText: 'Dropdown',
                  hintText: 'Select an option',
                  items: [
                    const LiquidGlassDropdownItem(
                      value: 'option1',
                      label: 'Option 1',
                    ),
                    const LiquidGlassDropdownItem(
                      value: 'option2',
                      label: 'Option 2',
                    ),
                    const LiquidGlassDropdownItem(
                      value: 'option3',
                      label: 'Option 3',
                    ),
                  ],
                  value: _selectedDropdown,
                  onChanged: (value) {
                    setState(() {
                      _selectedDropdown = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Choice (Single Select) Example
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Single Choice',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    LiquidGlassChoice<String>(
                      theme: customTheme,
                      options: const [
                        LiquidGlassChoiceOption(
                          value: 'choice1',
                          label: 'Choice 1',
                        ),
                        LiquidGlassChoiceOption(
                          value: 'choice2',
                          label: 'Choice 2',
                        ),
                        LiquidGlassChoiceOption(
                          value: 'choice3',
                          label: 'Choice 3',
                        ),
                      ],
                      value: _selectedChoice,
                      direction: Axis.horizontal,
                      spacing: 12,
                      onChanged: (value) {
                        setState(() {
                          _selectedChoice = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Multi-Choice Example
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Multi Choice',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    LiquidGlassMultiChoice<String>(
                      theme: customTheme,
                      options: const [
                        LiquidGlassMultiChoiceOption(
                          value: 'multi1',
                          label: 'Multi 1',
                        ),
                        LiquidGlassMultiChoiceOption(
                          value: 'multi2',
                          label: 'Multi 2',
                        ),
                        LiquidGlassMultiChoiceOption(
                          value: 'multi3',
                          label: 'Multi 3',
                        ),
                      ],
                      values: _selectedMultiChoice,
                      direction: Axis.horizontal,
                      spacing: 12,
                      onChanged: (values) {
                        setState(() {
                          _selectedMultiChoice = values;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Checkbox Example
                LiquidGlassCheckbox(
                  theme: customTheme,
                  value: _checkboxValue,
                  label: 'Accept terms and conditions',
                  onChanged: (value) {
                    setState(() {
                      _checkboxValue = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Radio Example
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Radio Buttons',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    LiquidGlassRadio<String>(
                      theme: customTheme,
                      value: 'radio1',
                      groupValue: _radioValue,
                      label: 'Radio Option 1',
                      onChanged: (value) {
                        setState(() {
                          _radioValue = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    LiquidGlassRadio<String>(
                      theme: customTheme,
                      value: 'radio2',
                      groupValue: _radioValue,
                      label: 'Radio Option 2',
                      onChanged: (value) {
                        setState(() {
                          _radioValue = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Button Examples
                Row(
                  children: [
                    Expanded(
                      child: LiquidGlassButton(
                        theme: customTheme,
                        text: 'Primary',
                        type: LiquidGlassButtonType.primary,
                        onPressed: () => debugPrint('Primary button pressed'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: LiquidGlassButton(
                        theme: customTheme,
                        text: 'Secondary',
                        type: LiquidGlassButtonType.secondary,
                        onPressed: () => debugPrint('Secondary button pressed'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LiquidGlassButton(
                  theme: customTheme,
                  text: 'Danger',
                  type: LiquidGlassButtonType.danger,
                  width: double.infinity,
                  onPressed: () => debugPrint('Danger button pressed'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
