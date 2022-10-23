// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:frontend/core/theme/colors.dart';

// Project imports:

//todo: move this widget into global folder
class CustomFormField extends StatefulWidget {
  final String fieldName;
  final TextEditingController textEditingController;
  final bool? isObscure;
  final String? Function(String? value)? validator;
  final String? label;
  final String? hint;
  const CustomFormField({
    Key? key,
    required this.textEditingController,
    this.isObscure = false,
    this.validator,
    this.label,
    this.hint,
    required this.fieldName,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isObscure = false;
  bool isNotPassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 16, right: 16),
      child: TextFormField(
        obscureText: isObscure,
        validator: widget.validator,
        controller: widget.textEditingController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 18),

          fillColor: Colors.white,

          //If not border

          // focusedBorder: InputBorder.none,
          // disabledBorder: InputBorder.none,
          // enabledBorder: InputBorder.none,
          // border: InputBorder.none,

          //If border
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: Colors.black),
          ),

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
          // errorMaxLines: 2,
          hintText: widget.hint,
          filled: true,
          hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                if (isObscure == true) {
                  isObscure = false;
                } else {
                  isObscure = true;
                }
              });
            },
            child: Icon(
              isObscure == true ? Icons.visibility : Icons.visibility_off,
              // color: AppColors.lightGrey,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    isObscure = widget.isObscure!;
  }
}
