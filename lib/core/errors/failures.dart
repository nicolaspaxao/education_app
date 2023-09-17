// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:education_app/core/errors/exceptions.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({required this.message, required this.statusCode})
      : assert(
          statusCode is String || statusCode is int,
          'StatusCode cannot be a ${statusCode.runtimeType}',
        );

  final String message;
  final dynamic statusCode;

  String get errorMessage => '$statusCode Erro: $message';

  @override
  List<dynamic> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
