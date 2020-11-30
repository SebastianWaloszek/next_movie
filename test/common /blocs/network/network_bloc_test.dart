import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:next_movie/common/blocs/network/network_bloc.dart';
import 'package:next_movie/common/blocs/network/network_event.dart';
import 'package:next_movie/common/blocs/network/network_state.dart';
import 'package:next_movie/common/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class NetworkInfoMock extends Mock implements NetworkInfo {}

void main() {
  NetworkInfo networkInfo;
  NetworkBloc networkBloc;

  setUp(() {
    networkInfo = NetworkInfoMock();
    when(networkInfo.onStatusChange).thenAnswer((_) => StreamController<DataConnectionStatus>().stream);
    networkBloc = NetworkBloc(networkInfo: networkInfo);
  });

  blocTest(
    'Should emit correct states when network becomes unavailable',
    build: () async => networkBloc,
    act: (bloc) async => bloc.add(NetworkIsUnavailableEvent()),
    expect: [
      NetworkUnavailableState(),
    ],
  );

  blocTest(
    'Should emit correct states when a unexpected network error occurs',
    build: () async => networkBloc,
    act: (bloc) async => bloc.add(UnexpectedNetworkErrorEvent()),
    expect: [
      UnexpectedNetworkErrorState(),
    ],
  );

  blocTest(
    'Should emit correct states when network becomes available after being unavailable',
    build: () async => networkBloc,
    act: (bloc) async {
      bloc.add(NetworkIsUnavailableEvent());
      return bloc.add(NetworkIsAvailableEvent());
    },
    expect: [
      NetworkUnavailableState(),
      NetworkAvailableState(),
    ],
  );

  blocTest(
    'Should emit correct states when network becomes available after an unexpected error',
    build: () async => networkBloc,
    act: (bloc) async {
      bloc.add(UnexpectedNetworkErrorEvent());
      return bloc.add(NetworkIsAvailableEvent());
    },
    expect: [
      UnexpectedNetworkErrorState(),
      NetworkAvailableState(),
    ],
  );
}
