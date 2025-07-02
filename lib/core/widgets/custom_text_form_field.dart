import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    required this.hintText,
    required this.onChanged,
    required this.textInputAction,
    required this.validator,
    required this.icon,
  });

  final String labelText;
  final String hintText;
  final bool obscureText;
  final void Function(String)? onChanged;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final IconData? icon;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;
  final GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        cursorColor: Color(0xff003367),
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 15,
        ),
        key: fieldKey,
        obscuringCharacter: '*',
        keyboardType: TextInputType.text,
        onChanged: (value) {
          widget.onChanged?.call(value);
          fieldKey.currentState?.validate();
        },
        obscureText: _obscureText,
        textInputAction: widget.textInputAction,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 2,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 15,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 252, 254, 252),
            fontSize: 15,
          ),
          suffixIcon: (widget.obscureText)
              ? IconButton(
                  icon: _obscureText
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          prefixIcon: Icon(widget.icon, color: Color(0xff003367)),
        ),
      ),
    );
  }
}
