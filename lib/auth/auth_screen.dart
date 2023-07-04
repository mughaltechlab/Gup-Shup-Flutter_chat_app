import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/register_or_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // if user login so return homescreen
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          // if user doesnt login so show loginscreen either signupscreen
          else {
            return const RegisterOrLogin();
          }
        },
      ),
    );
  }
}
