import 'package:dio/dio.dart';
import 'package:next_movie/common/blocs/network/network_bloc.dart';
import 'package:next_movie/common/blocs/network/network_event.dart';
import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/network/network_info.dart';
import 'package:next_movie/common/network/network_service_impl.dart';
import 'package:next_movie/common/result/failure_result.dart';
import 'package:next_movie/common/result/success_result.dart';
import 'package:next_movie/common/network/request.dart';
import 'package:next_movie/common/network/request_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class NetworkInfoMock extends Mock implements NetworkInfo {}

class NetworkBlocMock extends Mock implements NetworkBloc {}

class DioMock extends Mock implements Dio {}

class RequestMock extends Mock implements Request {}

abstract class Callable {
  void call() {}
}

class MockFunction extends Mock implements Callable {}

class PostMockRequest extends Request<void> {
  PostMockRequest() : super(path: 'path');

  @override
  void createResponse(void response) {}
}

void main() {
  NetworkInfo networkInfo;
  Dio dio;
  NetworkBloc networkBloc;

  NetworkServiceImpl networkService;

  PostMockRequest mockRequest;
  Response mockResponse;

  setUp(() {
    dio = DioMock();
    networkInfo = NetworkInfoMock();
    networkBloc = NetworkBlocMock();
    networkService = NetworkServiceImpl(
      networkInfo: networkInfo,
      dio: dio,
      networkBloc: networkBloc,
    );
    mockRequest = PostMockRequest();
    mockResponse = Response(data: 'data',statusCode: 200);
    when(networkInfo.isConnected).thenAnswer((_) async => true);
  });

  test('Should add event to bloc when request succeeds & return SuccessResult', () async {
    // Build
    when(dio.request(
      any,
      options: anyNamed('options'),
      queryParameters: anyNamed('queryParameters'),
      data: anyNamed('data'),
    )).thenAnswer((_) async => mockResponse);
    // Act
    final result = await networkService.make(mockRequest);
    // Expect
    final capturedEvent = verify(networkBloc.add(captureAny)).captured.single;
    expect(capturedEvent is NetworkIsAvailableEvent, isTrue);
    expect(result is SuccessResult, isTrue);
  });

  test('Should add event to bloc on ConnectionException & return FailureResult with NetworkFailure', () async {
    // Build
    when(dio.request(
      any,
      options: anyNamed('options'),
      queryParameters: anyNamed('queryParameters'),
      data: anyNamed('data'),
    )).thenThrow(ConnectionException(''));
    // Act
    final result = await networkService.make(mockRequest);
    // Expect
    final capturedEvent = verify(networkBloc.add(captureAny)).captured.single;
    expect(capturedEvent is NetworkIsUnavailableEvent, isTrue);
    expect(result is FailureResult, isTrue);
    result.fold(onFailure: (failure) => expect(failure is NetworkFailure, isTrue), onSuccess: (_) => {});
  });

  test('Should add event to bloc on network not connected & return FailureResult with NetworkFailure', () async {
    // Build
    when(networkInfo.isConnected).thenAnswer((_) async => false);
    // Act
    final result = await networkService.make(mockRequest);
    // Expect
    final capturedEvent = verify(networkBloc.add(captureAny)).captured.single;
    expect(capturedEvent is NetworkIsUnavailableEvent, isTrue);
    expect(result is FailureResult, isTrue);
    result.fold(onFailure: (failure) => expect(failure is NetworkFailure, isTrue), onSuccess: (_) => {});
  });

  test('Should add event to bloc on Exception & return FailureResult with UnexpectedFailure', () async {
    // Build
    when(dio.request(
      any,
      options: anyNamed('options'),
      queryParameters: anyNamed('queryParameters'),
      data: anyNamed('data'),
    )).thenThrow(Exception());
    // Act
    final result = await networkService.make(mockRequest);
    // Expect
    final capturedEvent = verify(networkBloc.add(captureAny)).captured.single;
    expect(capturedEvent is UnexpectedNetworkErrorEvent, isTrue);
    expect(result is FailureResult, isTrue);
    result.fold(onFailure: (failure) => expect(failure is UnexpectedFailure, isTrue), onSuccess: (_) => {});
  });
}
