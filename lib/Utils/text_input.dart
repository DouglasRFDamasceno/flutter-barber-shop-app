import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; // Importando o pacote de máscara

import 'colors.dart';

class TextInput extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool enabled;
  final bool showPasswordIcon;
  final TextInputFormatter? inputFormatter;  // Adicionando o campo para formatação de input

  const TextInput({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.hintText,
    this.obscureText = false,
    this.enabled = true,
    this.showPasswordIcon = false,
    this.inputFormatter,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      style: const TextStyle(fontSize: 24),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        enabled: widget.enabled,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: RetroColors.brown.shade500, width: 4),
        ),
        suffixIcon:
        widget.showPasswordIcon
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _togglePasswordVisibility,
        )
            : null,
      ),
      inputFormatters: widget.inputFormatter != null
          ? [widget.inputFormatter!]  // Aplica o inputFormatter caso exista
          : [],
    );
  }
}
