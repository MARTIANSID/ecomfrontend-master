import 'dart:io';

class HttpE implements SocketException {
  final String message;

  HttpE(this.message);

  @override
  String toString() {
    return message;
    // return super.toString(); // Instance of HttpException
  }

  @override
  InternetAddress get address => throw UnimplementedError();

  @override
  OSError get osError => throw UnimplementedError();

  @override
  int get port => throw UnimplementedError();
}
