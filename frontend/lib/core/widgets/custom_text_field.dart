// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Project imports:
import 'package:frontend/core/theme/app_style.dart';
import 'custom_form_field_decoration.dart';

class CustomTextField extends StatelessWidget {
  final String? attribute;
  final String? label;
  final String? hint;
  final bool? obscureText;
  final TextInputType? inputType;
  final FormFieldValidator<String>? validator;
  final InputDecoration? decoration;
  final bool? isFilled;
  final Color? filledColor;
  final Color? borderColor;
  final String? errorText;
  final int? maxLines;
  final bool? enabled;
  final TextInputType? keyboardType;
  final void Function(dynamic)? onChange;
  final void Function(dynamic)? onSaved;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final bool? expands;
  final TextStyle? style;
  final bool? enable;

  const CustomTextField(
      {this.attribute,
      this.enable,
      this.keyboardType,
      this.label,
      this.obscureText,
      this.inputType,
      this.validator,
      this.decoration,
      this.isFilled,
      this.filledColor,
      this.borderColor,
      this.errorText,
      this.onChange,
      this.onSaved,
      this.initialValue,
      this.suffixIcon,
      this.prefixIcon,
      this.textController,
      this.maxLines,
      this.enabled,
      this.focusNode,
      this.hint,
      this.expands,
      this.style});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      style: style ??
          AppStyle.blackTextLight.copyWith(
            fontSize: 16,
          ),
      enabled: enable ?? true,
      focusNode: focusNode,
      maxLines: maxLines ?? 1,
      readOnly: enabled ?? false,
      controller: textController,
      initialValue: initialValue,
      name: attribute ?? 'text',
      obscureText: obscureText ?? false,
      onChanged: onChange,
      onSaved: onSaved,
      validator: validator,
      expands: expands ?? false,
      keyboardType: inputType ?? TextInputType.text,
      decoration: decoration ??
          customFormFieldDecoration.copyWith(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            labelText: label,
            hintText: hint,
            hintStyle: AppStyle.blackTextMedium
                .copyWith(fontSize: 15, color: Colors.grey),
            filled: isFilled ?? true,
            fillColor: filledColor ?? Colors.grey.withOpacity(0.2),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: borderColor ?? Colors.grey.withOpacity(0.0),
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
    );
  }
}
