import 'package:prodigal/models/cake.dart';
import 'package:prodigal/models/module.dart';

class ModuleState {
  final bool fetching;
  final bool? fetchingSuccess;
  final String? fetchingError;

  final List<Module> modules;
  final List<Cake> cakes;

  final bool fetchingCakes;
  final bool? fetchingCakesSuccess;
  final String? fetchingCakesError;

  ModuleState({
    this.fetching = false,
    this.fetchingSuccess,
    this.fetchingError,
    this.fetchingCakes = false,
    this.fetchingCakesSuccess,
    this.fetchingCakesError,
    this.modules = const [],
    this.cakes = const [],
  });

  ModuleState copyWith({
    bool? fetching,
    bool? fetchingSuccess,
    String? fetchingError,
    bool? fetchingCakes,
    bool? fetchingCakesSuccess,
    String? fetchingCakesError,
    List<Module>? modules,
    List<Cake>? cakes,
  }) {
    return ModuleState(
      fetching: fetching ?? this.fetching,
      fetchingSuccess: fetchingSuccess,
      fetchingError: fetchingError,
      fetchingCakes: fetchingCakes ?? this.fetchingCakes,
      fetchingCakesSuccess: fetchingCakesSuccess,
      fetchingCakesError: fetchingCakesError,
      modules: modules ?? this.modules,
      cakes: cakes ?? this.cakes,
    );
  }
}
