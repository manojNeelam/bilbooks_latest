import 'package:billbooks_app/features/auth/data/models/reset_password_model.dart';
import 'package:billbooks_app/features/auth/data/models/reset_password_req_model.dart';
import 'package:billbooks_app/features/auth/data/models/user_model.dart';
import 'package:billbooks_app/features/auth/domain/usecases/user_signup.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_endpoint_urls.dart';
import '../../../../../core/api/api_exception.dart';
import '../../../domain/entities/reset_password_req_entity.dart';
import '../../models/register_user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> loginWithEmailandPassword({
    required String email,
    required String password,
  });

  Future<ResetPasswordResModel> resetpassword(
      ResetPasswordUseCaseReqParams params);

  Future<ForgotPasswordReqResEntity> resetpasswordRequest(
      ResetPasswordReqUseCaseReqParams params);
  Future<RegisterUserResModel> registerUser(
      RegisterUserUseCaseReqParams params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final APIClient apiClient;
  AuthRemoteDataSourceImpl(this.apiClient);
  @override
  Future<UserModel> loginWithEmailandPassword(
      {required String email, required String password}) async {
    try {
      Map<String, String> map = {
        "email": email,
        "password": password,
      };
      debugPrint(map.toString());

      FormData body = FormData.fromMap(map);
      final response =
          await apiClient.postRequest(path: ApiEndPoints.login, body: body);
      if (response.statusCode != 200) {
        throw ApiException(
            message: "Invalid status code ${response.statusCode}");
      }

      final resModel = UserModel.fromJson(response.data);
      if (resModel.data?.success != true) {
        throw ApiException(
            message:
                resModel.data?.message ?? "Request failed please try again!");
      }
      return resModel;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<ResetPasswordResModel> resetpassword(
      ResetPasswordUseCaseReqParams params) async {
    try {
      Map<String, String> map = {
        "hashkey": params.hashkey,
        "password": params.password,
        "confirm_password": params.confirmPassword,
      };
      debugPrint(map.toString());

      FormData body = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.resetPassword, body: body);
      if (response.statusCode != 200) {
        throw ApiException(
            message: "Invalid status code ${response.statusCode}");
      }
      final resModel = resetPasswordResModelFromJson(response.data);
      if (resModel.data?.success != true) {
        throw ApiException(
            message:
                resModel.data?.message ?? "Request failed please try again!");
      }
      return resModel;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<ForgotPasswordReqResEntity> resetpasswordRequest(
      ResetPasswordReqUseCaseReqParams params) async {
    try {
      Map<String, String> map = {
        "email": params.email,
        "hashkey": "generate_hashkey",
      };
      debugPrint(map.toString());

      FormData body = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.resetPassword, body: body);
      if (response.statusCode != 200) {
        throw ApiException(
            message: "Invalid status code ${response.statusCode}");
      }
      final resModel = forgotPasswordResModelFromJson(response.data);
      if (resModel.data?.success != true) {
        throw ApiException(
            message:
                resModel.data?.message ?? "Request failed please try again!");
      }
      return resModel;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<RegisterUserResModel> registerUser(
      RegisterUserUseCaseReqParams params) async {
    try {
      Map<String, String> map = {
        "company_name": params.company,
        "full_name": params.name,
        "email": params.email,
        "password": params.password,
        "lang": params.lang,
        "country": params.country,
        "request_from": "mobile-app"
      };
      /*
      company_name:NSS
full_name:Manoj Kumar
email:manojneelam14@gmail.com
password:12345678
lang:en
country:0
request_from:mobile-app
      */
      debugPrint(map.toString());

      FormData body = FormData.fromMap(map);
      final response =
          await apiClient.postRequest(path: ApiEndPoints.authUser, body: body);
      if (response.statusCode != 200) {
        throw ApiException(
            message: "Invalid status code ${response.statusCode}");
      }
      final resModel = registerUserResModelFromJson(response.data);
      if (resModel.data?.success != true) {
        throw ApiException(
            message:
                resModel.data?.message ?? "Request failed please try again!");
      }
      return resModel;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
