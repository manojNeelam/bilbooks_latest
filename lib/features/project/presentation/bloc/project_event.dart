part of 'project_bloc.dart';

@immutable
sealed class ProjectEvent {}

final class GetProjectListEvent extends ProjectEvent {
  final ProjectListParams projectListParams;
  GetProjectListEvent({required this.projectListParams});
}

final class AddProjectEvent extends ProjectEvent {
  final AddProjectParams addProjectParams;
  AddProjectEvent({required this.addProjectParams});
}

final class DeleteProjectEvent extends ProjectEvent {
  final DeleteProjectParams deleteProjectParams;
  DeleteProjectEvent({required this.deleteProjectParams});
}

final class UpdateProjectStatusEvent extends ProjectEvent {
  final UpdateProjectStatusParams updateProjectStatusParams;
  UpdateProjectStatusEvent({required this.updateProjectStatusParams});
}

final class GetProjectDetailEvent extends ProjectEvent {
  final ProjectDetailReqParams projectDetailReqParams;
  GetProjectDetailEvent({required this.projectDetailReqParams});
}
