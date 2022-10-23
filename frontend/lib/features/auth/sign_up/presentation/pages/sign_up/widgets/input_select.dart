// Flutter imports:
import 'package:flutter/material.dart';

class InputSelect extends StatelessWidget {
  const InputSelect({
    required this.name,
    required this.onPressed,
    // required this.currentSelectionGetter,
    this.isSelected = false,
    Key? key,
  }) : super(key: key);
  final String name;
  final bool isSelected;
  final Function(String)? onPressed;
  // Function(bool, String) currentSelectionGetter;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      onPressed: () => onPressed!(name),
      selected: isSelected,
      // onSelected: (bool value) =>
      //     widget.currentSelectionGetter(value, widget.name),

      isEnabled: true,
      side: const BorderSide(
        color: Color(0xFF10BDFF),
        width: 1.0,
      ),
      disabledColor: Colors.white,
      selectedColor: const Color(0xFF10BDFF),
      showCheckmark: false,

      // selectedColor: Color(0xFF10BDFF),
      // selected: true,
      backgroundColor: Colors.transparent,
      label: Text(name),
      labelStyle: TextStyle(
        fontSize: 16.0,
        color: isSelected ? Colors.white : const Color(0xFF707070),
      ),
    );
  }
}
