import 'package:prodigal/handlers/handlers.dart';
import 'package:prodigal/injection/injection.dart';
import 'package:prodigal/models/cake.dart';
import 'package:prodigal/services/dio_client.service.dart';

class CakeService {
  Future<ApiResponse<List<Cake>>> fetchBulk(int moduleId) async {
    try {
      final response = await sl<DioClientService>().get(
        '/cake',
        queryParameters: {'moduleId': moduleId},
      );

      final result = List.from(response['data']['cakes']);

      return ApiSuccessResponse(result: result.map((e) => Cake.fromJson(e)).toList());
    } catch (error) {
      return ApiErrorResponse(error: ApiErrorUtils.getDioException(error));
    }
  }
}
