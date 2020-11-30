import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:next_movie/common/network/request.dart';
import 'package:next_movie/common/network/request_exceptions.dart';

class NetworkService {
  final Dio dio;
  final bool supportsRefreshing;

  NetworkService({
    @required this.dio,
    this.supportsRefreshing = true,
  })  : assert(dio != null),
        assert(supportsRefreshing != null);

  Future<dynamic> make<T>(Request<T> request) {
    return _make<T>(
      request,
      refreshable: supportsRefreshing && request.refreshable,
    );
  }

  Future<dynamic> _make<T>(Request<T> request,
      {@required bool refreshable}) async {
    try {
      final response = await dio.request(
        request.path,
        options: Options(
          method: _methodString(request.method),
          headers: await _headersFor(request),
        ),
        queryParameters: request.queryParameters,
        data: request.body?.toMap(),
      );
      return _handleResponse<T>(request, response, refreshable);
    } on DioError catch (error) {
      _handleError(error);
    }
  }

  Future<dynamic> upload<T>(UploadRequest<T> request) {
    return _upload(request, supportsRefreshing && request.refreshable);
  }

  Future<dynamic> _upload<T>(UploadRequest<T> request, bool refreshable) async {
    try {
      final body = request.body?.toMap() ?? <String, dynamic>{};
      final file = await MultipartFile.fromFile(request.filePath);
      body.putIfAbsent(request.fileKey, () => file);
      final form = FormData.fromMap(body);
      final response = await dio.request(
        request.path,
        options: Options(
          method: _methodString(request.method),
          headers: await _headersFor(request),
        ),
        queryParameters: request.queryParameters,
        data: form,
        onSendProgress: request.progressCallback,
      );
      return _handleResponse(request, response, refreshable);
    } on DioError catch (error) {
      _handleError(error);
    }
  }

  Future<Map<String, dynamic>> _headersFor(Request request) async {
    return null;
  }

  Future<T> _handleResponse<T>(
      Request<T> request, Response response, bool refreshable) async {
    if (_requestSuccessful(response.statusCode)) {
      return request.createResponse(response.data);
    }
    throw RequestException.fromStatusCode(
        response.statusCode, response.statusMessage);
  }

  void _handleError(DioError error) {
    if (error.type == DioErrorType.CONNECT_TIMEOUT) {
      throw ConnectionException(error.message);
    } else {
      throw RequestException.fromStatusCode(
          error.response?.statusCode, error.message);
    }
  }

  bool _requestSuccessful(int statusCode) =>
      statusCode >= 200 && statusCode < 300;

  String _methodString(HttpMethod method) {
    switch (method) {
      case HttpMethod.get:
        return 'GET';
      case HttpMethod.post:
        return 'POST';
      case HttpMethod.put:
        return 'PUT';
      case HttpMethod.delete:
        return 'DELETE';
      case HttpMethod.patch:
        return 'PATCH';
    }
    throw UnsupportedError('$method is not supported');
  }
}

enum HttpMethod { get, post, put, patch, delete }
