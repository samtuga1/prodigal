import 'package:flutter/material.dart';
import 'package:prodigal/injection/injection.dart';
import 'package:prodigal/repositories/user.repo.dart';
import 'package:prodigal/services/auth.service.dart';
import 'package:prodigal/src/auth/state.dart';
import 'package:prodigal/utils/debouncer.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    ref.onDispose(_dispose);
    usernameCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    return AuthState();
  }

  late TextEditingController usernameCtrl;
  late TextEditingController passwordCtrl;
  final debounce = Debouncer(500);

  void _dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
  }

  void checkUserExist() async {
    state = state.copyWith(
      checkingUserExist: true,
      checkingUserExistError: '',
      checkingUserExistSuccess: null,
    );

    final response = await AuthService.checkUserExists(usernameCtrl.text.trim());

    response.fold(
      onSuccess: (result) async {
        state = state.copyWith(checkingUserExistSuccess: true, usernameExists: result);
      },
      onError: (error) {
        state = state.copyWith(checkingUserExistError: error.message, checkingUserExistSuccess: false);
      },
    );
    state = state.copyWith(checkingUserExist: false);
  }

  void login() async {
    state = state.copyWith(loading: true, loadingError: '', loadingSuccess: null);

    final response = await AuthService.login(usernameCtrl.text.trim(), passwordCtrl.text.trim());

    response.fold(
      onSuccess: (result) async {
        await sl<AuthedUserRepository>().save(user: result);
        state = state.copyWith(loadingSuccess: true, loading: false);
      },
      onError: (error) {
        print(error);
        state = state.copyWith(loadingError: error.message, loadingSuccess: false, loading: false);
      },
    );
  }

  void register() async {
    state = state.copyWith(loading: true, loadingError: '', loadingSuccess: null);

    final response = await AuthService.register(usernameCtrl.text.trim(), passwordCtrl.text.trim());

    response.fold(
      onSuccess: (result) async {
        await sl<AuthedUserRepository>().save(user: result);
        state = state.copyWith(loadingSuccess: true, loading: false);
      },
      onError: (error) {
        state = state.copyWith(loadingSuccess: false, loadingError: error.message, loading: false);
      },
    );
  }

  bool get validateFields {
    return usernameCtrl.text.trim().isNotEmpty && passwordCtrl.text.trim().isNotEmpty;
  }
}
