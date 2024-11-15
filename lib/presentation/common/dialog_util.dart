// lib/presentation/common/dialog_utils.dart

import 'package:flutter/material.dart';

enum DialogType { success, error }

Future<void> showCustomDialog({
  required BuildContext context,
  required DialogType type,
  required String title,
  required String message,
  String buttonText = 'OK',
}) {
  Color titleColor;
  IconData iconData;

  switch (type) {
    case DialogType.success:
      titleColor = Colors.green;
      iconData = Icons.check_circle;
      break;
    case DialogType.error:
      titleColor = Colors.red;
      iconData = Icons.error;
      break;
  }

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Icon(
            iconData,
            color: titleColor,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(color: titleColor),
          ),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(buttonText),
        ),
      ],
    ),
  );
}
