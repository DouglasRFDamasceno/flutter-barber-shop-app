import 'package:flutter/material.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String buttonText,
  Color? backgroundColor, // Cor de fundo do dialog
  Color? titleColor, // Cor do título
  Color? messageColor, // Cor da mensagem
  Color? buttonColor, // Cor do botão
  Color? buttonTextColor, // Cor do texto do botão
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: backgroundColor ?? Colors.white,
        title: Text(
          title,
          style: TextStyle(
            color: titleColor ?? Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(color: messageColor ?? Colors.black87, fontSize: 16),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: buttonColor ?? Colors.blue,
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                color: buttonTextColor ?? Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    },
  );
}
