import 'package:animated_login_fb_app/config/palette.dart';
import 'package:animated_login_fb_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    final user = Provider.of<User>(context);
    return Container(
      color: Palette.darkBlue.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 80, left: 20, right: 12, bottom: 20),
            child: Row(
              children: [
                CircleAvatar(
                  // backgroundColor: Palette.lightBlue,
                  backgroundColor: Colors.grey[800],
                  child: Center(
                    child: Image(
                      image: NetworkImage(
                          'https://picsum.photos/seed/image014/500/800'),
                    ),

                    // Text(
                    //   user.email[0],
                    //   style: TextStyle(
                    //       fontSize: 20,
                    //       color: Palette.darkOrange,
                    //       fontWeight: FontWeight.w900),
                    // ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.email,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Active Status",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, bottom: 50),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Colors.white70,
                    ),
                    Text(
                      "   settings   |   ",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    loginProvider.logout();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.white70,
                      ),
                      Text(
                        "   logout",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
