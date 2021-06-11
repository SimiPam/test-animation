import 'package:animated_login_fb_app/screens/auth/auth.dart';
import 'package:animated_login_fb_app/screens/auth/sing_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      return HomeScreen();
    } else {
      return AuthScreen();
    }
  }
}
