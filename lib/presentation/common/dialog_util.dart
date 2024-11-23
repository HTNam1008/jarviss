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
      iconData = Icons.error_outline;
      break;
  }

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                  color: titleColor,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              color: Colors.teal,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Nút hành động
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                // side: BorderSide( // Thêm màu viền
                //   color: Colors.teal,
                //   width: 1,
                // ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
