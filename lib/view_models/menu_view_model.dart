import 'package:flutter/material.dart';

class Menu {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function(BuildContext context) onTap;

  const Menu({this.title, this.icon, this.iconColor, this.onTap});
}

class MenuViewModel {
  double _sizeIcon = 80.0;
  Color _colorIcon = Colors.cyan;
  Color _color = Colors.white70;

  List<Menu> get items => <Menu>[
        Menu(
          title: 'Company',
          icon: Icons.business,
          iconColor: _colorIcon,
          onTap: (context) {},
        ),
        Menu(
          title: 'Map',
          icon: Icons.map,
          iconColor: _colorIcon,
          onTap: (context) {},
        ),
        Menu(
          title: 'Camera',
          icon: Icons.camera,
          iconColor: _colorIcon,
          onTap: (context) {},
        ),
        Menu(
          title: 'About',
          icon: Icons.people,
          iconColor: _colorIcon,
          onTap: (context) {},
        ),
      ];
}
