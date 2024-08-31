import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      required this.hintTitle,
      required this.obscure,
      required this.onChanged,
      required this.isPassword});
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
    return TextField(
      onChanged: widget.onChanged,
      style: Style.font18Medium(context),
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  checkPassword = !checkPassword;
                  if (checkPassword) {
                    widget.obscure = false;
                  } else {
                    widget.obscure = true;
                  }
                  setState(() {});
                },
                icon: checkPassword
                    ? const Icon(Icons.remove_red_eye_outlined)
                    : const Icon(Icons.remove_red_eye))
            : null,
        hintText: widget.hintTitle,
        hintStyle: Style.font18Medium(context)
            .copyWith(color: const Color(0xff626262)),
        fillColor: const Color(0xffF1F4FF),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 0, 13, 95), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
      ),
      cursorColor: const Color(0xff1F41BB),
      obscureText: widget.obscure,
    );
  }
}
