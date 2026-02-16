import 'package:flutter/material.dart';

import '../constants/style/text_style_features.dart';

class UsedFilled extends StatefulWidget {
  final String label;
  final bool isMandatory;
  final Function(String)? onSaved;
  final TextEditingController controller;

  final String? Function(String?)? validator; // Custom validator if needed
  final bool? obscureText;
  final bool? enabled;

  const UsedFilled({
    required this.label,
    required this.isMandatory,
    this.onSaved,
    this.obscureText = false,
    this.enabled = true,
    required this.controller,
    this.validator, // Add this line to accept a custom validator
    super.key,
  });

  @override
  State<UsedFilled> createState() => _UsedFilledState();
}

class _UsedFilledState extends State<UsedFilled> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenSpace = screenSize.height * screenSize.width;

    return Row(
      children: [
        Text(
          widget.label,
          style: TextStyleFeatures.generalTextStyle,
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(width: 25),
        SizedBox(
          width: screenSpace * 0.0004, // Set the desired width of the TextField
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.obscureText ?? false,
            onSaved: (value) {
              if (value != null) {
                widget.onSaved!(value);
              }
            },
            enabled: widget.enabled,
            decoration: InputDecoration(
              hintText: 'أدخل ${widget.label}',
              hintStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            validator: widget.validator ??
                (value) {
                  if (widget.isMandatory && (value == null || value.isEmpty)) {
                    return "لا يمكن ان يكون هذا الحقل فارغ";
                  }
                  return null;
                },
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
        const SizedBox(width: 20),
        if (widget.isMandatory)
          const Text(
            '*',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
            ),
            textDirection: TextDirection.rtl,
          ),
      ],
    );
  }
}
