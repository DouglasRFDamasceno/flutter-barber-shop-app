  import 'package:flutter/material.dart';

class SubmitButtom extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onPressed;

  const SubmitButtom({
    Key? key,
    required this.controller,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ??
              () {
            final texto = controller.text;
            print("Texto registrado: $texto");
            // Você pode colocar sua lógica aqui também.
          },
      child: const Text('Registrar'),
    );
  }
}
