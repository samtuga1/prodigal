import 'package:flutter/material.dart';
import 'package:prodigal/injection/injection.dart';
import 'package:prodigal/models/user.dart';
import 'package:prodigal/repositories/user.repo.dart';
import 'package:prodigal/src/auth/screens/sign_in.dart';
import 'package:prodigal/src/home/home_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  User? user;

  @override
  void initState() {
    setData();
    super.initState();
  }

  Future<void> setData() async {
    user = await sl<AuthedUserRepository>().getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return switch (user == null) {
      true => const SignInScreen(),
      false => const HomeScreen(),
    };
  }
}
