import 'package:chat_app/components/my_list_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? goToProfile;
  final void Function()? signOut;
  const MyDrawer({
    super.key,
    required this.goToProfile,
    required this.signOut,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.teal.shade100;
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            // header/logo/User_pic etc
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: color,
                  size: 100,
                ),
              ),

              // home tile
              MyListTile(
                iconData: Icons.home,
                title: 'HOME',
                color: Colors.teal,
                onTap: () => Navigator.pop(context),
              ),

              // profile tile
              MyListTile(
                iconData: Icons.person_2,
                title: 'PROFILE',
                color: Colors.teal,
                onTap: goToProfile,
              ),
            ],
          ),

          // signout tile
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: MyListTile(
              iconData: Icons.power_settings_new_outlined,
              title: 'LOGOUT',
              color: Colors.pink.shade300,
              onTap: signOut,
            ),
          ),
        ],
      ),
    );
  }
}
