import 'dart:async';
import 'dart:io';
import 'dart:convert';

// https://pub.dev/packages/http
import 'package:http/http.dart' as http;

// https://pub.dev/packages/connectivity
import 'package:connectivity/connectivity.dart';

WebResponseModel responseStatusModelFromJson(String str) =>
    WebResponseModel.fromJson(json.decode(str));

class WebResponseModel {
  WebResponseModel({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory WebResponseModel.fromJson(Map<String, dynamic> json) =>
      WebResponseModel(
        code: json["code"],
        message: json["message"],
      );
}

String apiBaseUrl = 'https:';

enum FetchingStatus { LOADING, ERROR, SUCCESS, NONE }

class ApiResponse<T> {
  FetchingStatus fetchingStatus = FetchingStatus.NONE;
  T data;
  String errorMessage;

  ApiResponse.none() : fetchingStatus = FetchingStatus.NONE;
  ApiResponse.loading() : fetchingStatus = FetchingStatus.LOADING;
  ApiResponse.success(this.data) : fetchingStatus = FetchingStatus.SUCCESS;
  ApiResponse.error(String message) {
    fetchingStatus = FetchingStatus.ERROR;
    errorMessage = message;
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}

class RequestHelper {
  Future<http.Response> get(String url) async {
    final request = http.get(url).timeout(Duration(seconds: 10));

    return await _errorAndResponseHandling(request);
  }

  Future<http.Response> post(String url, {dynamic body}) async {
    final request = http.post(url, body: body).timeout(Duration(seconds: 10));

    return await _errorAndResponseHandling(request);
  }

  Future<http.Response> fromStream(http.StreamedResponse response) async {
    final request =
        http.Response.fromStream(response).timeout(Duration(seconds: 10));

    return await _errorAndResponseHandling(request);
  }

  Future<http.Response> _errorAndResponseHandling(
      Future<http.Response> request) async {
    http.Response responseJson;
    try {
      final response = await request;
      var responseStatus = responseStatusModelFromJson(response.body);
      if (responseStatus.code == 0) {
        throw NetworkException(responseStatus.message);
      }

      responseJson = _returnResponse(response);
    } on SocketException {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw NetworkException('Tidak ada koneksi');
      }
      throw NetworkException('Bad Host');
    } on TimeoutException {
      throw NetworkException('Time out');
    } on FormatException {
      throw NetworkException('error');
    } on HandshakeException catch (e) {
      throw NetworkException(e.message);
    }
    return responseJson;
  }

  http.Response _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 404:
        throw NetworkException('HTTP Not Found');
      default:
        throw NetworkException('Error, Status code: ${response.statusCode}');
    }
  }
}
