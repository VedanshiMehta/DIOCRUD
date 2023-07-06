import 'package:crud_operation_dio/Utils/show_snackbar.dart';
import 'package:crud_operation_dio/common/result.dart';
import 'package:crud_operation_dio/models/user.dart';
import 'package:crud_operation_dio/services/user_api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends ChangeNotifier {
  List<Datum>? get datum => _data;
  List<Datum>? _data;
  Datum? get userDetails => _datum;
  Datum? _datum;
  bool get isUpdated => _isUpdated;
  late bool _isUpdated;

  int _currentIndex = 1;
  int _totalPage = 0;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void getUserAsync() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();
    var userdata = await UserService().getReqRes(_currentIndex);
    _data = userdata?.data;
    _totalPage = userdata?.totalPages ?? 0;
    Future.delayed(const Duration(seconds: 2), () {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> loadNextPage() async {
    if (_currentIndex >= _totalPage) return;
    notifyListeners();
    _currentIndex++;
    getUserAsync();
  }

  Future<void> refreshData() async {
    _currentIndex = 1;
    getUserAsync();
  }

  void deleteUser(int userId, BuildContext context) async {
    await UserService()
        .deleteUser(userId)
        .then((result) => Utils.showMessage(context, result!.message));

    notifyListeners();
  }

  Future<Result> updateUser(int userId) async {
    var result = await UserService().updateUser(userId);
    return result!;
  }

  Future<Result> addUser() async {
    var result = await UserService().addUser();
    return result!;
  }

  void getCurrentUser(Datum data, bool isUpdated) {
    _datum = data;
    _isUpdated = isUpdated;
    notifyListeners();
  }
}

final userProvider = ChangeNotifierProvider<UserNotifier>(
  (ref) => UserNotifier(),
);
