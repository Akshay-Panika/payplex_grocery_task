import 'package:flutter/material.dart';

import '../constant/app_color.dart';

class AppTextField extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  final bool obscure;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final int maxLines;
  final Function(String)? onChanged;

  const AppTextField({
    super.key,

    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,

    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        /// Label
        Text(
          label,

          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColor.muted,
            letterSpacing: 0.8,
          ),
        ),

        const SizedBox(height: 6),

        /// Field
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,

          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColor.title,
          ),

          decoration: InputDecoration(

            hintText: hint,

            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 15,
            ),

            prefixIcon: Icon(
              icon,
              color: AppColor.primaryLight,
              size: 20,
            ),

            suffixIcon: suffixIcon,

            filled: true,
            fillColor: AppColor.surface,

            contentPadding:
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),

            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(13),

              borderSide: const BorderSide(
                color: AppColor.primaryPale,
                width: 1.5,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(13),

              borderSide: const BorderSide(
                color: AppColor.primaryPale,
                width: 1.5,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(13),

              borderSide: const BorderSide(
                color: AppColor.primaryLight,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}