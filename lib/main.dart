import 'package:animated_login_fb_app/screens/auth/auth.dart';
import 'package:animated_login_fb_app/utils/themes.dart';
import 'package:animated_login_fb_app/widgets/sign_in_up_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [Icon(Icons.error), Text("something wemt wrong")],
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            // theme: myTheme,
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.montserratTextTheme(),
              accentColor: Palette.darkOrange,
              appBarTheme: const AppBarTheme(
                brightness: Brightness.dark,
                color: Palette.darkBlue,
              ),
            ),
            home: AuthScreen(),
          );
        } else {
          return Scaffold(
              body: Center(
            child: LoadingIndicator(isLoading: true),
          ));
        }
      },
    );
  }
}
