import 'package:crud_operation_dio/Utils/api_service.dart';
import 'package:crud_operation_dio/common/result.dart';
import 'package:crud_operation_dio/constants/api_url_constants.dart';
import 'package:crud_operation_dio/models/user.dart';
import 'package:flutter/material.dart';

Users? user;
Result? result;

class UserService {
  Future<Users?> getReqRes(int currentPage) async {
    String url =
        '${ApiUrlConstants.baseUrl}${ApiUrlConstants.userEndPoint}$currentPage';
    final response = await ApiService().getAsync(url: url);
    if (response != null && response.statusCode == 200) {
      user = userFromJson(response.data);
    } else {
      debugPrint("Error: ${response?.statusCode}: ${response?.statusMessage}");
    }
    return user;
  }

  Future<Result?> deleteUser(int userId) async {
    String url =
        '${ApiUrlConstants.baseUrl}${ApiUrlConstants.deleteUserEndPoint}$userId';
    final response = await ApiService().deleteAsync(url: url);
    if (response != null && response.statusCode == 200) {
      result = Result(message: "Deleted Successfully", isValid: true);
    } else {
      result = Result(message: "Something went wrong", isValid: false);
    }
    return result;
  }

  Future<Result?> updateUser(int userId) async {
    String url =
        '${ApiUrlConstants.baseUrl}${ApiUrlConstants.deleteUserEndPoint}$userId';
    final response = await ApiService().updateAsync(url: url);
    if (response != null && response.statusCode == 200) {
      result = Result(message: "Updated Successfully", isValid: true);
    } else {
      result = Result(message: "Something went wrong", isValid: false);
    }
    return result;
  }

  Future<Result?> addUser() async {
    String url = '${ApiUrlConstants.baseUrl}${ApiUrlConstants.addUserEndPoint}';
    final response = await ApiService().addAsync(url: url);
    if (response != null && response.statusCode == 201) {
      result = Result(message: "Added Successfully", isValid: true);
    } else {
      result = Result(message: "Something went wrong", isValid: false);
    }
    return result;
  }
}
