import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.label,
      this.placeholder,
      this.onSaved,
      this.validator,
      this.keyboardType,
      this.initialValue,
      this.onTap,
      this.controller,
      this.readOnly = false,
      this.expands = false,
      this.obscureText = false});

  final String label;
  final String? placeholder;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? initialValue;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  final bool readOnly;
  final bool expands;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final place =
        (placeholder == '' || placeholder == null) ? label : placeholder;
    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      style: const TextStyle(color: Colors.black),
      decoration: customInputDecoration(
        context: context,
        label: label,
        placeholder: place!,
      ),
      onSaved: onSaved,
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.name,
      initialValue: initialValue,
      onTap: onTap,
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
    );
  }

  OutlineInputBorder _crearBordeInput(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  InputDecoration customInputDecoration({
    required BuildContext context,
    required String label,
    required String placeholder,
  }) {
    return InputDecoration(
      hintStyle: const TextStyle(color: Colors.grey),
      labelStyle: TextStyle(color: Theme.of(context).primaryColor),
      hintText: placeholder,
      labelText: label,
      focusedErrorBorder: _crearBordeInput(context),
      errorBorder: _crearBordeInput(context),
      focusedBorder: _crearBordeInput(context),
      enabledBorder: _crearBordeInput(context),
      alignLabelWithHint: true,
    );
  }
}
