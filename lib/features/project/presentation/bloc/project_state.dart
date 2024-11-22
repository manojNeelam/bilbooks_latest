part of 'project_bloc.dart';

@immutable
sealed class ProjectState {}

final class ProjectInitial extends ProjectState {}

final class ProjectListLoading extends ProjectState {}

final class ProjectListError extends ProjectState {
  final String errorMessage;
  ProjectListError({required this.errorMessage});
}

final class ProjectListSuccess extends ProjectState {
  final ProjectMainResEntity projectMainResEntity;
  ProjectListSuccess({required this.projectMainResEntity});
}

final class AddProjectLoading extends ProjectState {}

final class AddProjectError extends ProjectState {
  final String errorMessage;
  AddProjectError({required this.errorMessage});
}

final class AddProjectSuccess extends ProjectState {
  final AddProjectMainResponseEntity addProjectMainResponseEntity;
  AddProjectSuccess({required this.addProjectMainResponseEntity});
}

final class DeleteProjectLoadingState extends ProjectState {}

final class DeleteProjectSuccessState extends ProjectState {
  final ProjectDeleteMainResEntity projectDeleteMainResEntity;
  DeleteProjectSuccessState({required this.projectDeleteMainResEntity});
}

final class DeleteProjectErrorState extends ProjectState {
  final String errorMessage;
  DeleteProjectErrorState({required this.errorMessage});
}

final class UpdateProjectStatusLoadingState extends ProjectState {}

final class UpdateProjectStatusSuccessState extends ProjectState {
  final ProjectStatusUpdateMainResEntity projectStatusUpdateMainResEntity;
  UpdateProjectStatusSuccessState(
      {required this.projectStatusUpdateMainResEntity});
}

final class UpdateProjectStatusErrorState extends ProjectState {
  final String errorMessage;
  UpdateProjectStatusErrorState({required this.errorMessage});
}

final class ProjectDetailLoadingState extends ProjectState {}

final class ProjectDetailErrorState extends ProjectState {
  final String errorMessage;
  ProjectDetailErrorState({required this.errorMessage});
}

final class ProjectDetailSuccessState extends ProjectState {
  final ProjectDetailMainResEntity projectDetailMainResEntity;
  ProjectDetailSuccessState({required this.projectDetailMainResEntity});
}
