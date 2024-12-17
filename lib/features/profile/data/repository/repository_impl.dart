import 'package:billbooks_app/core/error/failures.dart';

import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
import 'package:billbooks_app/features/profile/data/remote/profile_datasource.dart';
import 'package:billbooks_app/features/profile/domain/entity/profile_entity.dart';

import 'package:billbooks_app/features/profile/domain/usecase/profile_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/api/api_exception.dart';
import '../../domain/repository/repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl({required this.profileRemoteDataSource});
  @override
  Future<Either<Failure, AuthInfoMainResEntity>> selectOraganization(
      SelectOrganizationReqParams params) async {
    try {
      final res = await profileRemoteDataSource.selectOrganization(params);
      debugPrint("ProfileRepository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("ProfileRepository: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("ProfileRepository: default error");

      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateMyProfileResponseEntity>> updateProfile(
      UpdateProfileReqParams params) async {
    try {
      final res = await profileRemoteDataSource.updateProfile(params);
      debugPrint("Update Profile: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Update Profile: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Update Profile: default error");

      return left(Failure(e.toString()));
    }
  }
}
