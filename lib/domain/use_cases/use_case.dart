import 'package:next_movie/common/error/failure.dart';

import '../../common/result/result.dart';


abstract class UseCase<T, P> {
  Future<Result<T, Failure>> call(P parameters);
}