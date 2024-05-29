import 'package:flutter/material.dart';
import 'package:tatpmmobil/widgets/style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({required this.controller, required this.hint, this.isObscure = false, this.hasSuffix = false, this.onPressed, super.key,});

  final TextEditingController controller;
  final String hint;
  final bool isObscure;
  final bool hasSuffix;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        suffixIcon: hasSuffix ? IconButton(onPressed: onPressed, icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off)) : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.0, color: AppColors.darkGrey,),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.0, color: AppColors.darkGrey,),
          borderRadius: BorderRadius.circular(12.0),
        ),
        hintText: hint,
        hintStyle: TextStyles.body,
      ),
    );
  }
}
