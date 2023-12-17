import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiService {
  final Dio _dio;

  final _baseUrl = "https://www.backend.support-constructions.com";

  ApiService(this._dio) {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<Map<String, dynamic>> get(
      {required String endPoint,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    var response = await _dio.get('$_baseUrl$endPoint',
        data: data,
        options: Options(headers: headers),
        queryParameters: queryParameters);
    return response.data;
  }

  Future<Response> dioResponse(
      {required String endPoint,
      Map<String, dynamic>? data,
      FormData? formData,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    var response = await _dio.get('$_baseUrl$endPoint',
        data: data ?? formData,
        options: Options(headers: headers),
        queryParameters: queryParameters);
    return response;
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint,
      Map<String, dynamic>? data,
      FormData? formData,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    var response = await _dio.post('$_baseUrl$endPoint',
        data: data ?? formData,
        options: Options(headers: headers),
        queryParameters: queryParameters);
    return response.data;
  }

  Future<Map<String, dynamic>> put(
      {required String endPoint,
      Map<String, dynamic>? data,
      FormData? formData,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    var response = await _dio.put('$_baseUrl$endPoint',
        data: data ?? formData,
        options: Options(headers: headers),
        queryParameters: queryParameters);
    return response.data;
  }
}
