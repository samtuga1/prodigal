import 'package:flutter/material.dart';
import 'package:prodigal/handlers/api_error/api_error.handler.dart';
import 'package:prodigal/handlers/api_response/api_response.handler.dart';

extension StringExt on String {
  String get initials => split(' ').map((word) => word.isNotEmpty ? word[0].toUpperCase() : '').join();
}

extension ContextExtension on BuildContext {
  ColorScheme get colorScheme => theme.colorScheme;

  NavigatorState get navigator => Navigator.of(this);

  Size get size => MediaQuery.sizeOf(this);

  double get height => size.height;
  double get width => size.width;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
}

extension ErrorMessage on ApiError {
  String get message => ApiErrorUtils.getErrorMessage(this);
}

extension ApiResponseMapping<T> on ApiResponse<T> {
  R map<R>({
    required R Function(T data) onSuccess,
    required R Function(ApiError error) onError,
  }) {
    return switch (this) {
      ApiSuccessResponse<T>(result: var data) => onSuccess(data),
      ApiErrorResponse<T>(error: var error) => onError(error),
    };
  }

  void fold({
    required void Function(T data) onSuccess,
    required void Function(ApiError error) onError,
  }) {
    switch (this) {
      case ApiSuccessResponse<T>(result: var data):
        onSuccess(data);
      case ApiErrorResponse<T>(error: var error):
        onError(error);
    }
  }
}

extension WidgetPadding on Widget {
  Widget paddingAll(double padding) => Padding(padding: EdgeInsets.all(padding), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical), child: this);

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(padding: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom), child: this);

  Widget get paddingZero => Padding(padding: EdgeInsets.zero, child: this);
}
