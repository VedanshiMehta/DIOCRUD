import 'package:flutter/material.dart';

class FileSelectorItems extends StatelessWidget {
  const FileSelectorItems(
      {super.key,
      required this.text,
      required this.icons,
      required this.onTap});
  final String text;
  final void Function() onTap;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(
          icons,
          size: 26,
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Colors.deepPurpleAccent,
          ),
          foregroundColor: Colors.deepPurpleAccent,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        label: Text(text),
      ),
    ]);
  }
}
