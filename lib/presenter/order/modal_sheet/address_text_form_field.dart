import 'package:flutter/material.dart';

class AddressTextFormField extends StatelessWidget {
  const AddressTextFormField({Key? key, required this.hint, required this.controller}) : super(key: key);
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (text) {
        if (text!.isEmpty) {
          return 'Por favor rellena todos los campos';
        }
      },
      controller: controller,
      decoration: const InputDecoration( //вынести отдельно
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
