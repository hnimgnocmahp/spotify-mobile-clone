import 'package:flutter/material.dart';
import 'package:flutter_spotify/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget ? title;
  final Widget ? action;
  final bool hideBack;
  const BasicAppBar({super.key, this.title,this.action, this.hideBack = false});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: title ?? const SizedBox.shrink(),
      actions: [
        action ?? const SizedBox.shrink(),
      ],
      centerTitle: true,
      leading: hideBack ? null : IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: context.isDarkMode ? Colors.white.withOpacity(0.03) : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: context.isDarkMode ? Colors.white : Colors.black,
              size: 20,
            ),
          )
      ),
    );

  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}