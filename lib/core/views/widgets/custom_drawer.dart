import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  Widget? child;
  CustomDrawer({super.key,this.child});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: child,
    );
  }
}
