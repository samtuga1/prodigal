import 'package:equatable/equatable.dart';
import 'package:prodigal/handlers/api_error/api_error.handler.dart';

sealed class ApiResponse<T> extends Equatable {}

class ApiSuccessResponse<T> extends ApiResponse<T> {
  final T result;

  ApiSuccessResponse({required this.result});
  @override
  List<Object?> get props => [result];
}

class ApiErrorResponse<T> extends ApiResponse<T> {
  final ApiError error;

  ApiErrorResponse({required this.error});
  @override
  List<Object?> get props => [error];
}
