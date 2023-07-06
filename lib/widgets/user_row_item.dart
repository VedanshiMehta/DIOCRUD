import 'package:crud_operation_dio/models/user.dart';
import 'package:crud_operation_dio/widgets/circle_image.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.data});
  final Datum data;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        leading: RoundImage(imageUrl: data.avatar),
        title: Text(
          '${data.firstName} ${data.lastName}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          data.email,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
