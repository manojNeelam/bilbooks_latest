import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/project/domain/entity/add_project_main_response_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_delete_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_details_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';
import 'package:billbooks_app/features/project/domain/repository/project_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/project_update_status_entity.dart';

class ProjectListUsecase
    implements UseCase<ProjectMainResEntity, ProjectListParams> {
  final ProjectRepository projectRepository;
  ProjectListUsecase({required this.projectRepository});
  @override
  Future<Either<Failure, ProjectMainResEntity>> call(ProjectListParams params) {
    return projectRepository.getProjects(params);
  }
}

class ProjectListParams {
  String status;
  String query;
  String sortColumn;
  String sortOder;
  String? clientId;
  String page;
  ProjectListParams({
    required this.status,
    this.query = "",
    required this.sortColumn,
    required this.sortOder,
    this.clientId,
    required this.page,
  });
}

class AddProjectUseCase
    implements UseCase<AddProjectMainResponseEntity, AddProjectParams> {
  final ProjectRepository projectRepository;
  AddProjectUseCase({required this.projectRepository});
  @override
  Future<Either<Failure, AddProjectMainResponseEntity>> call(
      AddProjectParams params) {
    return projectRepository.addProjects(params);
  }
}

class AddProjectParams {
  String name, client, description, status;
  String? id;
  AddProjectParams({
    required this.name,
    required this.client,
    required this.description,
    required this.status,
    this.id,
  });
}

class DeleteProjectUserCase
    implements UseCase<ProjectDeleteMainResEntity, DeleteProjectParams> {
  final ProjectRepository projectRepository;
  DeleteProjectUserCase({required this.projectRepository});
  @override
  Future<Either<Failure, ProjectDeleteMainResEntity>> call(
      DeleteProjectParams params) {
    return projectRepository.deleteProject(params);
  }
}

class DeleteProjectParams {
  String id;
  DeleteProjectParams({required this.id});
}

class UpdateProjectStatusUseCase
    implements
        UseCase<ProjectStatusUpdateMainResEntity, UpdateProjectStatusParams> {
  final ProjectRepository projectRepository;
  UpdateProjectStatusUseCase({required this.projectRepository});
  @override
  Future<Either<Failure, ProjectStatusUpdateMainResEntity>> call(
      UpdateProjectStatusParams params) {
    return projectRepository.updateProjectStatus(params);
  }
}

class UpdateProjectStatusParams {
  String id;
  bool isActive;
  UpdateProjectStatusParams({required this.id, required this.isActive});
}

class ProjectDetailUseCase
    implements UseCase<ProjectDetailMainResEntity, ProjectDetailReqParams> {
  final ProjectRepository projectRepository;
  ProjectDetailUseCase({required this.projectRepository});
  @override
  Future<Either<Failure, ProjectDetailMainResEntity>> call(
      ProjectDetailReqParams params) {
    return projectRepository.getProjectDetails(params);
  }
}

class ProjectDetailReqParams {
  final String id;
  ProjectDetailReqParams({required this.id});
}
