import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Color? titleColor;
  final double? titleFontSize;
  final PreferredSizeWidget? bottom;
  final Widget? action;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.titleColor = Colors.black,
    this.titleFontSize = 24,
    this.bottom,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: mainColor),
        onPressed: onBackPressed ?? () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: titleFontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      bottom: bottom,
      actions: action == null ? null : [action!],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      kToolbarHeight + (bottom?.preferredSize.height ?? 0)); // Adjust height
}
