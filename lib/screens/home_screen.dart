import 'package:animated_login_fb_app/screens/drawer_screen.dart';
import 'package:animated_login_fb_app/screens/task_screen.dart';
import 'package:animated_login_fb_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);

    return Scaffold(
      // floatingActionButton: FloatingActionButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          DrawerScreen(),
          TaskScreen(),
        ],
      ),
    );
  }
}
