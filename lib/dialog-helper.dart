// import 'package:bpms/alert_dialog.dart';

import 'package:dictionary/alert_dialog.dart';
import 'package:flutter/material.dart';
// import 'alert_dialog.dart';

class DialogHelper {
  static dislog(context, icon, title, subTitle, type, color, theme) => showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          icon: icon,
          title: title,
          subTitle: subTitle,
          type: type,
          color: color,
          theme: theme
        ),
      );
}
