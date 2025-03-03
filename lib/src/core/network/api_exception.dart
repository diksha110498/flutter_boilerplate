abstract class ApiException implements Exception {
  final message;
  final prefix;

  ApiException(this.message, this.prefix);

  @override
  String toString() {
    return message != null ? '$message' : prefix;
  }
}

abstract class CustomApiException implements ApiException {
  final message;
  final prefix;
  final data;

  CustomApiException(this.message, this.prefix, {this.data});
}

class EmptyResultApiException extends ApiException {
  EmptyResultApiException() : super(null, 'No Data');
}

class BadRequestException extends ApiException {
  BadRequestException(message) : super(message, 'Invalid Request');
}

class UnauthorisedException extends ApiException {
  UnauthorisedException(message) : super(message, 'Unauthorised');
}

class FetchDataException extends ApiException {
  FetchDataException(message) : super(message, 'Error During Communication');
}

class NotFoundException extends ApiException {
  NotFoundException(message, {data}) : super(message, 'Not Found');
}

class CustomNotFoundException extends CustomApiException {
  CustomNotFoundException(message, {data})
      : super(message, 'Not Found', data: data);
}

class ConnectionException extends ApiException {
  ConnectionException(message) : super(message, 'Connection Error');
}

class BadResponseException extends ApiException {
  BadResponseException(message) : super(message, 'Bad Response');
}
