import 'package:flutter/material.dart';
import 'package:vocabmate/widgets/theme.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    this.isEnabled = true,
    this.hintText =
        '''Copy the text of a few slides and paste it into this text field.
Supports all languages.''',
  });

  final bool isEnabled;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: mediumViolet,
        width: 2,
      ),
    );
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(fontWeight: FontWeight.normal)),
      minLines: 6,
      maxLines: 12,
      enabled: isEnabled,
      keyboardType: TextInputType.multiline,
    );
  }
}
