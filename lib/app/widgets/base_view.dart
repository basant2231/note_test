import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  const BaseView({
    super.key,
    required this.child,
    this.appBar,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: child,
    );
  }
}
