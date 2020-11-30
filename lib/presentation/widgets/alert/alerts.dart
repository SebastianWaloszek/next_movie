import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../localization/app_localizations.dart';
import 'alert_parts.dart';

abstract class Alerts {
  static Widget createAlert(BuildContext context, {Widget title, Widget content, List<Widget> actions}) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return _materialAlert(title, content, actions);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return _cupertinoAlert(title, content, actions);
    }
    throw UnsupportedError('Platform ${Theme.of(context).platform} is not supported');
  }

  static AlertDialog _materialAlert(Widget title, Widget content, List<Widget> actions) {
    return AlertDialog(
      title: title,
      actions: actions,
      content: content,
    );
  }

  static CupertinoAlertDialog _cupertinoAlert(Widget title, Widget content, List<Widget> actions) {
    return CupertinoAlertDialog(
      title: title,
      actions: actions,
      content: content,
    );
  }

  static void showUnexpectedErrorAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return createAlert(
          context,
          content: Text(
            AppLocalizations.of(context).unexpectedError(),
          ),
          actions: <Widget>[
            AlertParts.okButton(context, onPressed: () => Navigator.pop(context)),
          ],
        );
      },
    );
  }
}
