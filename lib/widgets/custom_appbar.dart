import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.green[800],
      title: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.pets,
                  color: Colors.white,
                  size: 34,
                ),
                SizedBox(width: 8),
                Text(
                  'WildSnap',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Switch(
              value: true,
              inactiveTrackColor: Colors.yellow[400],
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
