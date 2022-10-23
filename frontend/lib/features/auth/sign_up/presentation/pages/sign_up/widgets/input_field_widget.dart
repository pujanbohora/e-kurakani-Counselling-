// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:frontend/core/theme/colors.dart';

// Package imports:

typedef ValidatorFunc = String? Function(String?);

class InputField extends StatefulWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType keyBoardType;
  final Function(String) getInputFieldValue;
  final ValidatorFunc validator;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool isCapitalized;
  const InputField(
      {required this.validator,
      required this.textEditingController,
      required this.getInputFieldValue,
      required this.hintText,
      this.isCapitalized = false,
      this.focusNode,
      this.keyBoardType = TextInputType.text,
      this.inputFormatters = const [],
      this.textInputAction,
      Key? key})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 16, right: 16),
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: isObscure,
        autovalidateMode: widget.focusNode != null
            ? widget.focusNode!.hasFocus
                ? AutovalidateMode.always
                : AutovalidateMode.disabled
            : AutovalidateMode.disabled,
        focusNode: widget.focusNode,
        textCapitalization: widget.isCapitalized
            ? TextCapitalization.words
            : TextCapitalization.none,
        validator: (String? value) => widget.validator(value),
        onChanged: (String value) => widget.getInputFieldValue(value),
        keyboardType: widget.keyBoardType,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: CustomColors.black),
          ),
          filled: true,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Inter',
            fontSize: 15,
          ),
          hintText: widget.hintText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              )),
        ),
      ),
    );
  }
}
