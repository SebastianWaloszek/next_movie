import 'package:flutter/foundation.dart';
import 'package:next_movie/common/error/failure.dart';

abstract class Result<S, F extends Failure> {
  R fold<R>({@required R Function(S) onSuccess, @required R Function(F) onFailure});
}
