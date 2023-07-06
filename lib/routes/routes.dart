import 'package:crud_operation_dio/constants/routes_constants.dart';
import 'package:crud_operation_dio/screens/get_list.dart';
import 'package:crud_operation_dio/screens/update.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();
  static final routes = <String, WidgetBuilder>{
    RoutesConstants.getList: (BuildContext context) => const UsersScreen(),
    RoutesConstants.update: (BuildContext context) => const UpdateUser(),
  };
}
