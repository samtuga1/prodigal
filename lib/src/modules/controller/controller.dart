import 'package:prodigal/injection/injection.dart';
import 'package:prodigal/services/cake.service.dart';
import 'package:prodigal/services/module.service.dart';
import 'package:prodigal/src/modules/state.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller.g.dart';

@riverpod
class ModulesController extends _$ModulesController {
  @override
  ModuleState build() {
    fetchModules();
    return ModuleState();
  }

  // fetch bulk modules
  Future<void> fetchModules() async {
    await Future.value(1);

    state = state.copyWith(
      fetching: true,
      fetchingError: '',
      fetchingSuccess: null,
    );

    final response = await sl<ModuleService>().fetchBulk();

    response.fold(
      onSuccess: (result) async {
        state = state.copyWith(fetchingSuccess: true, modules: result);
      },
      onError: (error) {
        state = state.copyWith(fetchingError: error.message, fetchingSuccess: false);
      },
    );
    state = state.copyWith(fetching: false);
  }

  // fetch bulk cakes
  Future<void> fetchCakes(int moduleId) async {
    await Future.value(1);

    state = state.copyWith(
      fetchingCakes: true,
      fetchingCakesError: '',
      fetchingCakesSuccess: null,
    );

    final response = await sl<CakeService>().fetchBulk(moduleId);

    response.fold(
      onSuccess: (result) async {
        state = state.copyWith(fetchingCakesSuccess: true, cakes: result);
      },
      onError: (error) {
        state = state.copyWith(fetchingCakesError: error.message, fetchingCakesSuccess: false);
      },
    );
    state = state.copyWith(fetchingCakes: false);
  }
}
