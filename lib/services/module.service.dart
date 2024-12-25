import 'package:prodigal/handlers/handlers.dart';
import 'package:prodigal/injection/injection.dart';
import 'package:prodigal/models/module.dart';
import 'package:prodigal/services/dio_client.service.dart';

class ModuleService {
  Future<ApiResponse<List<Module>>> fetchBulk() async {
    try {
      final response = await sl<DioClientService>().get('/module');

      final result = List.from(response['data']['modules']);

      return ApiSuccessResponse(result: result.map((e) => Module.fromJson(e)).toList());
    } catch (error) {
      return ApiErrorResponse(error: ApiErrorUtils.getDioException(error));
    }
  }
}
