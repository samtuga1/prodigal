import 'package:prodigal/handlers/handlers.dart';
import 'package:prodigal/injection/injection.dart';
import 'package:prodigal/models/user.dart';
import 'package:prodigal/services/dio_client.service.dart';

class AuthService {
  static Future<ApiResponse<bool>> checkUserExists(String username) async {
    try {
      final response = await sl<DioClientService>().post('/auth/check', data: {'username': username});

      return ApiSuccessResponse(result: response['data']['exist']);
    } catch (error) {
      return ApiErrorResponse(error: ApiErrorUtils.getDioException(error));
    }
  }

  static Future<ApiResponse<User>> getUser(int id) async {
    try {
      final response = await sl<DioClientService>().post('/auth/user/$id');

      return ApiSuccessResponse(result: User.fromJson(response['data']['user']));
    } catch (error) {
      return ApiErrorResponse(error: ApiErrorUtils.getDioException(error));
    }
  }

  static Future<ApiResponse<User>> login(String username, password) async {
    try {
      final response = await sl<DioClientService>().post('/auth/login', data: {
        'username': username,
        'password': password,
      });

      return ApiSuccessResponse(result: User.fromJson(response['data']['user']));
    } catch (error) {
      return ApiErrorResponse(error: ApiErrorUtils.getDioException(error));
    }
  }

  static Future<ApiResponse<User>> register(String username, password) async {
    try {
      final response = await sl<DioClientService>().post('/auth/register', data: {
        'username': username,
        'password': password,
      });

      return ApiSuccessResponse(result: User.fromJson(response['data']['user']));
    } catch (error) {
      return ApiErrorResponse(error: ApiErrorUtils.getDioException(error));
    }
  }
}
