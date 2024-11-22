import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/project/data/datasource/project_datasource.dart';
import 'package:billbooks_app/features/project/domain/entity/add_project_main_response_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_delete_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_details_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_update_status_entity.dart';
import 'package:billbooks_app/features/project/domain/repository/project_repository.dart';
import 'package:billbooks_app/features/project/domain/usecase/project_usecase.dart';
import 'package:fpdart/fpdart.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectDatasource projectDatasource;
  ProjectRepositoryImpl({required this.projectDatasource});
  @override
  Future<Either<Failure, ProjectMainResEntity>> getProjects(
      ProjectListParams params) async {
    try {
      final resModel = await projectDatasource.getProjectList(params);
      return right(resModel);
    } on ApiException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddProjectMainResponseEntity>> addProjects(
      AddProjectParams params) async {
    try {
      final resModel = await projectDatasource.addProject(params);
      return right(resModel);
    } on ApiException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProjectDeleteMainResEntity>> deleteProject(
      DeleteProjectParams params) async {
    try {
      final resModel = await projectDatasource.deleteProject(params);
      return right(resModel);
    } on ApiException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProjectStatusUpdateMainResEntity>> updateProjectStatus(
      UpdateProjectStatusParams params) async {
    try {
      final resModel = await projectDatasource.updateStatus(params);
      return right(resModel);
    } on ApiException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProjectDetailMainResEntity>> getProjectDetails(
      ProjectDetailReqParams params) async {
    try {
      final resModel = await projectDatasource.getProjectDetails(params);
      return right(resModel);
    } on ApiException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
