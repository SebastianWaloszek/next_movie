import 'package:flutter/material.dart';

import '../../localization/app_localizations.dart';

/// Alert specific parts used while creating an alert in [Alerts].
abstract class AlertParts {
  static Widget cancelButton(BuildContext context, {@required Function() onPressed}) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        AppLocalizations.of(context).cancel(),
      ),
    );
  }

  static Widget destructiveExitButton(BuildContext context, {@required Function() onPressed}) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        AppLocalizations.of(context).exit(),
      ),
    );
  }

  static Widget okButton(BuildContext context, {@required Function() onPressed}) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        AppLocalizations.of(context).ok(),
      ),
    );
  }
}
