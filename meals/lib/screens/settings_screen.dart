import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = 'settings';

  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
