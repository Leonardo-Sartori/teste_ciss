import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_ciss/shared/utils/ui_info/strings_ui_info.dart';

// ignore: must_be_immutable
class AppTextfield extends StatelessWidget {
  String text;
  bool? invisible;
  TextEditingController? controller;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  FocusNode? nextFocus;
  bool? autoFocus;
  bool? readOnly;
  int? maxLines;
  bool required;
  TextInputType? inputType = TextInputType.text;
  TextCapitalization textCapitalization;
  ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? maskFormatter;

  AppTextfield(
    this.text,
    this.textCapitalization, {Key? key, 
    this.invisible,
    this.controller,
    this.maxLines,
    this.required = true,
    this.textInputAction,
    this.autoFocus,
    this.focusNode,
    this.validator,
    this.inputType,
    this.onChanged,
    this.readOnly,
    this.maskFormatter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxLines != null && maxLines! > 1 ? 95 : 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextFormField(
          inputFormatters: maskFormatter,
          readOnly: readOnly != null ? readOnly! : false,
          controller: controller,
          onChanged: onChanged,
          validator: required ? _validRequired : null,
          textInputAction: textInputAction,
          focusNode: focusNode,
          maxLines: maxLines,
          autofocus: autoFocus ?? false,
          textCapitalization: textCapitalization,
          onFieldSubmitted: (String text) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            }
          },
          decoration: InputDecoration(
            labelText: text,
            labelStyle: const TextStyle(
                fontSize: 15,),
          ),
          keyboardType: inputType,
        ),
      ),
    );
  }

  String? _validRequired(String? value) {
    if (value == null || value.isEmpty) {
      return StringsUiInfo.requiredField;
    }

    return null;
  }
}
