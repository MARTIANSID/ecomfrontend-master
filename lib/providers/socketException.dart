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
  // TODO: implement address
  InternetAddress get address => throw UnimplementedError();

  @override
  // TODO: implement osError
  OSError get osError => throw UnimplementedError();

  @override
  // TODO: implement port
  int get port => throw UnimplementedError();
}
