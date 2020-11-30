import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';

abstract class Failure extends Equatable {
  String toLocalizedMessage(BuildContext context);

  @override
  List<Object> get props => [];
}

class NetworkFailure extends Failure {
  @override
  String toLocalizedMessage(BuildContext context) => AppLocalizations.of(context).noInternetFound();
}

class UnexpectedFailure extends Failure {
  @override
  String toLocalizedMessage(BuildContext context) => AppLocalizations.of(context).unexpectedError();
}

class AuthenticationFailure extends Failure {
  @override
  String toLocalizedMessage(BuildContext context) => AppLocalizations.of(context).authenticationFailed();
}
