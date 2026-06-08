import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';

class LoginFieldForm extends StatefulWidget {
  final String? title;
  final String inputlabel;
  final bool obscureText;
  final TextEditingController controller;
  final bool showTitle;
  final TextInputType? inputType;
  // final void Function()? submitField;
  final Widget? prefixIcon;

  const LoginFieldForm({
    super.key,
    this.title,
    required this.inputlabel,
    this.obscureText = false,
    required this.controller,
    this.showTitle = true,
    this.inputType,
    // this.submitField,
    this.prefixIcon,
  });

  @override
  State<LoginFieldForm> createState() => _LoginFieldFormState();
}

class _LoginFieldFormState extends State<LoginFieldForm> {
  final height = Get.height;
  final width = Get.width;

  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    final isPasswordField = widget.obscureText;
    return Column(
      children: [
        if (widget.showTitle) Text(widget.title ?? widget.inputlabel),
        TextFormField(
          autofocus: true,
          controller: widget.controller,
          obscureText: isPasswordField ? !isPasswordVisible : false,
          keyboardType: widget.inputType,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: height * 0.02,
            color: SDWcolors.textD,
            fontWeight: FontWeight.normal,
            ),
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            label: Text(widget.inputlabel),
            hintText: !widget.showTitle ? widget.inputlabel : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            suffixIcon: isPasswordField
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
