import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/src/core/themes/extensions/build_context_extension.dart';

import '../themes/themes.dart';

class InputComponent extends StatefulWidget {
  const InputComponent({
    super.key,
    this.label,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.errorText,
    this.initialValue,
    this.inputFormatters = const [],
    this.obscureText = false,
    this.suffixIcon,
    this.hintStyle,
    this.enabled,
    this.textFieldStyle,
    this.labelStyle,
  });

  const InputComponent.password({
    super.key,
    required this.label,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.errorText,
    this.initialValue,
    this.inputFormatters = const [],
    this.obscureText = true,
    this.suffixIcon,
    this.hintStyle,
    this.enabled,
    this.textFieldStyle,
    this.labelStyle,
  });

  const InputComponent.number({
    super.key,
    this.label,
    this.hintText,
    this.validator,
    this.onChanged,
    this.controller,
    this.errorText,
    this.initialValue,
    this.keyboardType = const TextInputType.numberWithOptions(),
    this.inputFormatters = const [],
    this.obscureText = false,
    this.suffixIcon,
    this.hintStyle,
    this.enabled,
    this.textFieldStyle,
    this.labelStyle,
  });

  const InputComponent.phone({
    super.key,
    required this.label,
    required this.hintText,
    this.errorText,
    this.validator,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.keyboardType = TextInputType.phone,
    this.inputFormatters = const [],
    this.obscureText = false,
    this.suffixIcon,
    this.hintStyle,
    this.enabled,
    this.textFieldStyle,
    this.labelStyle,
  });

  const InputComponent.email({
    super.key,
    required this.label,
    required this.hintText,
    this.errorText,
    this.validator,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.keyboardType = TextInputType.emailAddress,
    this.inputFormatters = const [],
    this.obscureText = false,
    this.suffixIcon,
    this.hintStyle,
    this.enabled,
    this.textFieldStyle,
    this.labelStyle,
  });

  const InputComponent.date({
    super.key,
    required this.label,
    required this.hintText,
    this.errorText,
    this.validator,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.keyboardType = TextInputType.datetime,
    this.inputFormatters = const [],
    this.obscureText = false,
    this.suffixIcon,
    this.hintStyle,
    this.enabled,
    this.textFieldStyle,
    this.labelStyle,
  });
  final String? initialValue;
  final String? errorText;
  final String? label;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter> inputFormatters;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final TextStyle? textFieldStyle;
  final TextStyle? labelStyle;
  final bool? enabled;

  @override
  State<InputComponent> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  late bool _obscured;

  void _toggleObscured() => setState(() => _obscured = !_obscured);

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      initialValue: widget.initialValue,
      controller: widget.controller,
      obscureText: _obscured,
      style: widget.textFieldStyle ??
          context.textTheme.bodySmall!.copyWith(
            fontSize: 16,
            letterSpacing: .5,
            color: AppColors.blackSecondary2,
            fontWeight: FontWeight.w500,
          ),
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: widget.suffixIcon,
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey50)),
        hintStyle: widget.hintStyle,
        errorText: widget.errorText,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: _toggleObscured,
                icon: Icon(_obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              )
            : null,
        label: widget.label != null
            ? Text(
                widget.label!,
                style: widget.labelStyle,
              )
            : null,
        hintText: widget.hintText,
      ),
    );
  }
}
