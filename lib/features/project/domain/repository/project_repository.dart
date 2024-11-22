import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/project/domain/entity/project_details_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_update_status_entity.dart';
import 'package:billbooks_app/features/project/presentation/bloc/project_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/add_project_main_response_entity.dart';
import '../entity/project_delete_entity.dart';
import '../usecase/project_usecase.dart';

abstract interface class ProjectRepository {
  Future<Either<Failure, ProjectMainResEntity>> getProjects(
      ProjectListParams params);
  Future<Either<Failure, AddProjectMainResponseEntity>> addProjects(
      AddProjectParams params);
  Future<Either<Failure, ProjectDeleteMainResEntity>> deleteProject(
      DeleteProjectParams params);
  Future<Either<Failure, ProjectStatusUpdateMainResEntity>> updateProjectStatus(
      UpdateProjectStatusParams params);
  Future<Either<Failure, ProjectDetailMainResEntity>> getProjectDetails(
      ProjectDetailReqParams params);
}
