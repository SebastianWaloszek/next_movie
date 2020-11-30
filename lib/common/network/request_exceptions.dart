abstract class RequestException implements Exception {
  final String message;

  RequestException(this.message);

  factory RequestException.fromStatusCode(int statusCode, String message) {
    if (statusCode != null) {
      if (statusCode == 401) return UnauthorizedException(message);
      if (statusCode >= 400 && statusCode < 500) return ClientRequestException(message);
      if (statusCode >= 500) return ServerRequestException(message);
    }
    return UnexpectedException(message, statusCode);
  }
}

class UnauthorizedException extends RequestException {
  UnauthorizedException(String message) : super(message);
}

class ConnectionException extends RequestException {
  ConnectionException(String message) : super(message);
}

class ClientRequestException extends RequestException {
  ClientRequestException(String message) : super(message);
}

class ServerRequestException extends RequestException {
  ServerRequestException(String message) : super(message);
}

class UnexpectedException extends RequestException {
  final int statusCode;

  UnexpectedException(String message, this.statusCode) : super(message);
}
