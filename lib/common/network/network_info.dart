import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

  Stream<DataConnectionStatus> get onStatusChange;
}

class NetworkInfoImpl implements NetworkInfo {
  DataConnectionChecker dataConnectionChecker;

  NetworkInfoImpl(this.dataConnectionChecker) : assert(dataConnectionChecker != null);

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;

  @override
  Stream<DataConnectionStatus> get onStatusChange => dataConnectionChecker.onStatusChange;
}
