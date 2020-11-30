import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:next_movie/common/network/network_service.dart';

abstract class RequestBody {
  Map<String, dynamic> toMap();
}

abstract class Request<T> {
  final String path;
  final HttpMethod method;
  final bool needsAuthorization;
  final RequestBody body;
  final Map<String, dynamic> queryParameters;
  final bool refreshable;

  T createResponse(dynamic json);

  Request({
    @required this.path,
    this.method = HttpMethod.get,
    this.needsAuthorization = true,
    this.body,
    this.queryParameters,
    this.refreshable = true,
  })  : assert(path != null),
        assert(method != null),
        assert(needsAuthorization != null),
        assert(refreshable != null);
}

abstract class UploadRequest<T> extends Request<T> {
  final String filePath;
  final String fileKey;
  final ProgressCallback progressCallback;

  UploadRequest({
    @required this.filePath,
    @required this.fileKey,
    @required String path,
    this.progressCallback,
    HttpMethod method = HttpMethod.get,
    bool needsAuthorization = true,
    RequestBody body,
    Map<String, dynamic> queryParameters,
    bool refreshable = true,
  })  : assert(filePath != null),
        assert(fileKey != null),
        super(
          path: path,
          method: method,
          needsAuthorization: needsAuthorization,
          body: body,
          queryParameters: queryParameters,
          refreshable: refreshable,
        );
}
