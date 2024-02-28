



import 'package:dio/dio.dart';

class GenericException implements Exception {
  final String message;

  GenericException(this.message);
}

class AppException implements Exception {
  final Object error;
  final ErrorType type;
  final int? statusCode;
  final Response<dynamic>? res;

  AppException({required this.error, required this.type, this.statusCode,this.res});
}

enum ErrorType {
  dioError,
  firebaseError,
  appError,
}