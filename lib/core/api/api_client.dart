import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../utils/utils.dart';
import 'api_constants.dart';
import 'api_exception.dart';

class APIClient {
  late Dio dio;
  late BaseOptions baseOptions;

  APIClient() {
    baseOptions = BaseOptions(
        baseUrl: ApiConstant.mainUrl,
        headers: {"x-api-key": "WhMF1i3V6uJYwCUItvgmLwNeetIHCobi"});
    dio = Dio(baseOptions);
  }

  ///GET Request
  Future<Response> getRequest(String path,
      {Map<String, dynamic> queryParameters = const {}}) async {
    //dio.interceptors.add(PrettyDioLogger());
    var token = await Utils.getToken();
    final options = Options(
      headers: {
        "x-access-token": "$token",
      },
    );
    dio.interceptors.add(PrettyDioLogger());

    try {
      // 404
      debugPrint("==========Api Request ==========");
      //debugPrint("Request URL: ${baseOptions.baseUrl + ApiEndPoints.login}");
      var response = await dio.get(path,
          queryParameters: queryParameters, options: options);
      //debugPrint(response.toString());
      // debugPrint("==========Api Response ==========");
      // debugPrint("Status Code: ${response.statusCode.toString()}");
      // debugPrint("Data: ${response.data}");
      // log("Data: ${response.data}");

      debugPrint("Success");
      return response;
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
        debugPrint(e.response!.requestOptions.toString());
        throw ApiException(message: e.response!.statusMessage);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
        throw ApiException(message: e.message);
      }
    }
  }

  Future<Response> postRequest({required String path, dynamic body}) async {
    var token = await Utils.getToken();
    final options = Options(
      headers: {
        "x-access-token": "$token",
      },
    );
    dio.interceptors.add(PrettyDioLogger());

    try {
      // 404
      // debugPrint("==========Api Request ==========");
      debugPrint("Request Body: $body");
      var response = await dio.post(path, data: body, options: options);
      debugPrint("==========Api Response ==========");
      debugPrint("Status Code: ${response.statusCode.toString()}");
      debugPrint("Data: ${response.data}");

      //debugPrint(response.data);
      return response;
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
        debugPrint(e.response!.requestOptions.toString());
        throw ApiException(message: e.response!.statusMessage);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
        throw ApiException(message: e.message);
      }
    }
  }

  Future<Response> deleteRequest(
      {required String path, dynamic queryParameters}) async {
    var token = await Utils.getToken();
    final options = Options(
      headers: {
        "x-access-token": "$token",
      },
    );
    dio.interceptors.add(PrettyDioLogger());

    try {
      // 404
      // debugPrint("==========Api Request ==========");
      debugPrint("Request Body: $queryParameters");
      debugPrint("PATH: $path");
      var response = await dio.delete(path,
          queryParameters: queryParameters, options: options);
      debugPrint("==========Api Response ==========");
      debugPrint("Status Code: ${response.statusCode.toString()}");
      debugPrint("Data: ${response.data}");
      //log("Data: ${response.data}");

      debugPrint(response.data);
      return response;
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
        debugPrint(e.response!.requestOptions.toString());
        throw ApiException(message: e.response!.statusMessage);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
        throw ApiException(message: e.message);
      }
    }
  }
}
