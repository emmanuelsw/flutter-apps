import 'package:flutter/material.dart';
import 'package:meals/screens/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            leading: Icon(
              Icons.restaurant,
              size: 26,
            ),
            title: Text(
              'Meals',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName);
            },
            leading: Icon(
              Icons.settings,
              size: 26,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          )
        ],
      ),
    );
  }
}
