class AuthState {
  final bool loading;
  final bool? loadingSuccess;
  final String? loadingError;

  final bool checkingUserExist;
  final bool? checkingUserExistSuccess;
  final String? checkingUserExistError;

  final bool usernameExists;

  AuthState({
    this.loading = false,
    this.loadingSuccess,
    this.loadingError,
    this.checkingUserExist = false,
    this.checkingUserExistSuccess,
    this.checkingUserExistError,
    this.usernameExists = false,
  });

  AuthState copyWith({
    bool? loading,
    bool? loadingSuccess,
    String? loadingError,
    bool? checkingUserExist,
    bool? checkingUserExistSuccess,
    String? checkingUserExistError,
    bool? usernameExists,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      loadingSuccess: loadingSuccess,
      loadingError: loadingError,
      checkingUserExist: checkingUserExist ?? this.checkingUserExist,
      checkingUserExistSuccess: checkingUserExistSuccess,
      checkingUserExistError: checkingUserExistError,
      usernameExists: usernameExists ?? this.usernameExists,
    );
  }
}
