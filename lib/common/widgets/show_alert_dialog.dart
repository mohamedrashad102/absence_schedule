import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

showAlertDialog(
  BuildContext context, {
  Function()? onAccept,
  Function()? onDeny,
  String? acceptTitle,
  String? denyTitle,
  Widget? content,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            content ?? const SizedBox(),
            content != null ? const Gap(5) : const SizedBox(),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    if (onAccept != null) onAccept();
                    Navigator.pop(context);
                  },
                  child: Text(
                    acceptTitle ?? 'حفظ',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (onDeny != null) onDeny();
                    Navigator.pop(context);
                  },
                  child: Text(
                    denyTitle ?? 'الغاء',
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}


