import 'package:dio/dio.dart';
import 'package:next_movie/common/network/network_service.dart';
import 'package:next_movie/common/network/request.dart';
import 'package:next_movie/common/result/failure_result.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/common/result/success_result.dart';
import 'package:next_movie/common/network/request_exceptions.dart';
import 'package:meta/meta.dart';

import '../error/failure.dart';
import 'network_info.dart';

class NetworkServiceImpl extends NetworkService {
  final NetworkInfo networkInfo;

  NetworkServiceImpl({
    @required this.networkInfo,
    @required Dio dio,
  })  : assert(networkInfo != null),
        super(dio: dio);

  @override
  Future<Result<T, Failure>> make<T>(Request<T> request) async {
    Future<dynamic> requestFunction() => super.make(request);
    return _perform(requestFunction, request);
  }

  @override
  Future<Result<T, Failure>> upload<T>(UploadRequest<T> request) async {
    Future<dynamic> requestFunction() => super.upload(request);
    return _perform(requestFunction, request);
  }

  Future<Result<T, Failure>> _perform<T>(Function requestFunction, Request<T> request) async {
    if (!await networkInfo.isConnected) {
      return FailureResult<T, NetworkFailure>(NetworkFailure());
    }
    try {
      final result = await requestFunction.call();
      return SuccessResult(result as T);
    } on ConnectionException {
      return FailureResult<T, NetworkFailure>(NetworkFailure());
    } on UnauthorizedException {
      return FailureResult<T, AuthenticationFailure>(AuthenticationFailure());
    } on Exception {
      return FailureResult<T, UnexpectedFailure>(UnexpectedFailure());
    }
  }
}
