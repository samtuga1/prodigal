import 'dart:convert';
import 'package:prodigal/models/user.dart';
import 'package:prodigal/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthedUserRepository {
  SharedPreferences prefs;

  AuthedUserRepository(this.prefs);

  Future<User?> getUser() async {
    final user = prefs.getString(userKey);
    if (user == null) return null;
    final decodedUser = await jsonDecode(user);
    return User.fromJson(decodedUser);
  }

  Future<void> save({required User user}) async {
    final encodedUserData = jsonEncode(user.toJson());

    await prefs.setString(userKey, encodedUserData);
  }

  Future<void> delete() async {
    await prefs.remove(userKey);
  }
}
