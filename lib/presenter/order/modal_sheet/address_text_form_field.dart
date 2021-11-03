import 'package:flutter/material.dart';

class AddressTextFormField extends StatelessWidget {
  const AddressTextFormField(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.label})
      : super(key: key);
  final String hint;
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (text) {
        if (text!.isEmpty) {
          return 'Por favor rellena todos los campos';
        }
      },
      controller: controller,
      decoration: InputDecoration(
        //вынести отдельно
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
