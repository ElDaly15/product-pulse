import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.hintTitle,
    required this.obscure,
    required this.onChanged,
    required this.isPassword,
  });
  final String hintTitle;
  bool obscure;

  final Function(String)? onChanged;
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool checkPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        cursorColor: const Color(0xff1F41BB), // Cursor color
        selectionColor: const Color(0xff1F41BB)
            .withOpacity(0.42), // Selection highlight color
        selectionHandleColor: const Color(0xff1F41BB), // Handle color
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This Field Is Required';
          }
          if (widget.isPassword) {
            if (value.length < 8) {
              return 'Password must be at least 8 characters';
            }
          }
          return null;
        },
        onChanged: widget.onChanged,
        style: Style.font18Medium(context),
        decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        checkPassword = !checkPassword;
                        widget.obscure = !checkPassword;
                      });
                    },
                    icon: checkPassword
                        ? const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Color.fromARGB(255, 0, 13, 95),
                          )
                        : const Icon(
                            Icons.remove_red_eye,
                            color: Color.fromARGB(255, 0, 13, 95),
                          ),
                  )
                : null,
            hintText: widget.hintTitle,
            hintStyle: Style.font18Medium(context)
                .copyWith(color: const Color(0xff626262)),
            fillColor: const Color(0xffF1F4FF),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 0, 13, 95), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 0, 13, 95), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
            errorStyle: Style.font14Bold(context).copyWith(color: Colors.red)),
        cursorColor: const Color(0xff1F41BB),
        obscureText: widget.obscure,
      ),
    );
  }
}
