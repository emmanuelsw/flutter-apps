import 'package:flutter/material.dart';
import 'package:meals/utils/style.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  Widget _buildSwitchListTile(String title, String subtitle, bool value, Function updateVal) {
    return SwitchListTile(
      title: Text(
        title,
        style: AppStyle.bold,
      ),
      subtitle: Text(subtitle),
      value: value,
      onChanged: updateVal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Adjust your meal selection',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              _buildSwitchListTile(
                'Gluten Free',
                'Only include gluten free meals.',
                _glutenFree,
                (newVal) {
                  setState(() {
                    _glutenFree = newVal;
                  });
                }
              ),
              _buildSwitchListTile(
                'Vegetarian',
                'Only include vegetarian meals.',
                _vegetarian,
                (newVal) {
                  setState(() {
                    _vegetarian = newVal;
                  });
                }
              ),
              _buildSwitchListTile(
                'Vegan',
                'Only include vegan meals.',
                _vegan,
                (newVal) {
                  setState(() {
                    _vegan = newVal;
                  });
                }
              ),
              _buildSwitchListTile(
                'Lactose Free',
                'Only include lactose free meals.',
                _lactoseFree,
                (newVal) {
                  setState(() {
                    _lactoseFree = newVal;
                  });
                }
              ),
            ],
          ),
        ),
      ],
    );
  }
}
