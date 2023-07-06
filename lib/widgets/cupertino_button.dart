import 'package:flutter/cupertino.dart';

class CupertinoButtonWidget extends StatelessWidget {
  const CupertinoButtonWidget({
    super.key,
    required this.onTap,
    required this.child,
  });
  final void Function() onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      child: child,
    );
  }
}
