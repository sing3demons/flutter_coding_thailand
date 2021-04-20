import 'package:flutter/material.dart';
import 'package:flutter_coding_thailand/routes/routes.dart';

class Menu {
  final String title;
  final IconData icon;
  final Color iconColor;
  final double size;
  final Color color;

  final Function(BuildContext context) onTap;

  const Menu(
      {this.title,
      this.icon,
      this.iconColor,
      this.size,
      this.color,
      this.onTap});
}

class MenuViewModel {
  double _sizeIcon = 80.0;
  Color _colorIcon = Colors.cyan;
  Color _color = Colors.white70;

  List<Menu> get items => <Menu>[
        Menu(
          title: 'Company',
          icon: Icons.business,
          size: _sizeIcon,
          color: _color,
          iconColor: _colorIcon,
          onTap: (context) {
            Navigator.pushNamed(context, Routes.company);
          },
        ),
        Menu(
          title: 'Map',
          icon: Icons.map,
          size: _sizeIcon,
          color: _color,
          iconColor: _colorIcon,
          onTap: (context) {},
        ),
        Menu(
          title: 'Camera',
          icon: Icons.camera,
          size: _sizeIcon,
          color: _color,
          iconColor: _colorIcon,
          onTap: (context) {},
        ),
        Menu(
          title: 'Covid',
          icon: Icons.hotel,
          size: _sizeIcon,
          color: _color,
          iconColor: _colorIcon,
          onTap: (context) {
            Navigator.pushNamed(context, Routes.covid);
          },
        ),
        Menu(
          title: 'Room',
          icon: Icons.person,
          size: _sizeIcon,
          color: _color,
          iconColor: _colorIcon,
          onTap: (context) {
            Navigator.pushNamed(context, Routes.room);
          },
        ),
        Menu(
          title: 'About',
          icon: Icons.people,
          size: _sizeIcon,
          color: _color,
          iconColor: _colorIcon,
          onTap: (context) async {
            var result =
                await Navigator.pushNamed(context, Routes.about, arguments: {
              'email': 'sing3demons@livew.com',
            });
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('$result')));
          },
        ),
      ];
}
