import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
