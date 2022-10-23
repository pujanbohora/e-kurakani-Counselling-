// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// Project imports:
import '../theme/app_style.dart';

// import 'package:dropdown_search/dropdown_search.dart';


class CustomDropdown extends StatelessWidget {
  final String? attribute;
  final InputDecoration? decoration;
  final bool? allowClear;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final List<String>? items;
  final void Function(dynamic)? onChange;
  final String? initialValue;

  const CustomDropdown({
    this.attribute,
    this.decoration,
    this.allowClear,
    this.hintText,
    this.validator,
    this.items,
    this.onChange,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      name: attribute ?? 'category',
      onChanged: onChange,
      initialValue: initialValue,
      decoration: decoration ??
          const InputDecoration(
            labelText: 'Category',
          ),
      allowClear: allowClear ?? true,
      style: AppStyle.blackTextRegular.copyWith(fontSize: 12),
      hint: Text(
        hintText ?? 'Select category',
        style: AppStyle.blackTextRegular.copyWith(
          fontSize: 12,
        ),
      ),
      validator: FormBuilderValidators.required(
          errorText: 'Category field is required.'),
      items: (items ??
              [
                'Medicinal',
                'Business',
                'Education',
              ])
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category,
                style: AppStyle.blackTextRegular.copyWith(
                  fontSize: 13,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
