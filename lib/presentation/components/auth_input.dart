import 'package:flutter/material.dart';

class AuthInput extends StatelessWidget {
  final IconData icon;
  final String hint;
  final void Function(String)? onChanged;

  const AuthInput(
      {required this.icon,
      required this.hint,
      required this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 12),
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          prefixIcon: Icon(icon),
          hintText: hint,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        ),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'this field is required!';
          }
          return null;
        },
      ),
    );
  }
}
