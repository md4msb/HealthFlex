import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';

class ApiClient {
  final _dio = Dio();

  Future<Map<String, dynamic>?> getRequest(url, {Map<String, dynamic>? queryParameters}) async {
    Response response;
    try {
      response = await _dio.get(url, queryParameters: queryParameters);
      return response.data;
    } on TimeoutException {
      throw 'Api Timeout';
    } catch (e) {
      log("[Error] ${e.toString()}");
    }
    return null;
  }
}

ApiClient apiClient = ApiClient();
