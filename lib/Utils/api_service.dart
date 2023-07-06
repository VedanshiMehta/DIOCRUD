import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  Future<Response?> getAsync({required String url}) async {
    try {
      return _dio.get(url);
    } on DioException catch (ex) {
      throw "error: $ex";
    }
  }

  Future<Response?> addAsync({required String url}) async {
    try {
      return _dio.post(url);
    } on DioException catch (ex) {
      throw "error: $ex";
    }
  }

  Future<Response?> deleteAsync({required String url}) async {
    try {
      return _dio.delete(url);
    } on DioException catch (ex) {
      throw "error: $ex";
    }
  }

  Future<Response?> updateAsync({required String url}) async {
    try {
      return _dio.put(url);
    } on DioException catch (ex) {
      throw "error: $ex";
    }
  }
}
