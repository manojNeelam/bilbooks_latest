import 'package:billbooks_app/features/project/domain/entity/project_delete_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_details_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_update_status_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/add_project_main_response_entity.dart';
import '../../domain/usecase/project_usecase.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectListUsecase _projectListUsecase;
  final AddProjectUseCase _addProjectUseCase;
  final DeleteProjectUserCase _deleteProjectUserCase;
  final UpdateProjectStatusUseCase _updateProjectStatusUseCase;
  final ProjectDetailUseCase _projectDetailUseCase;

  ProjectBloc({
    required ProjectListUsecase projectListUsecase,
    required AddProjectUseCase addProjectUseCase,
    required DeleteProjectUserCase deleteProjectUserCase,
    required UpdateProjectStatusUseCase updateProjectStatusUseCase,
    required ProjectDetailUseCase projectDetailUseCase,
  })  : _projectListUsecase = projectListUsecase,
        _addProjectUseCase = addProjectUseCase,
        _deleteProjectUserCase = deleteProjectUserCase,
        _updateProjectStatusUseCase = updateProjectStatusUseCase,
        _projectDetailUseCase = projectDetailUseCase,
        super(ProjectInitial()) {
    on<GetProjectListEvent>((event, emit) async {
      emit(ProjectListLoading());
      final response = await _projectListUsecase.call(event.projectListParams);
      response.fold((l) => emit(ProjectListError(errorMessage: l.message)),
          (r) => emit(ProjectListSuccess(projectMainResEntity: r)));
    });
    on<AddProjectEvent>((event, emit) async {
      emit(AddProjectLoading());
      final response = await _addProjectUseCase.call(event.addProjectParams);
      response.fold((l) => emit(AddProjectError(errorMessage: l.message)),
          (r) => emit(AddProjectSuccess(addProjectMainResponseEntity: r)));
    });

    on<DeleteProjectEvent>((event, emit) async {
      emit(DeleteProjectLoadingState());
      final response =
          await _deleteProjectUserCase.call(event.deleteProjectParams);
      response.fold(
          (l) => emit(DeleteProjectErrorState(errorMessage: l.message)),
          (r) =>
              emit(DeleteProjectSuccessState(projectDeleteMainResEntity: r)));
    });

    on<UpdateProjectStatusEvent>((event, emit) async {
      emit(UpdateProjectStatusLoadingState());
      final response = await _updateProjectStatusUseCase
          .call(event.updateProjectStatusParams);
      debugPrint("UpdateProjectStatusEvent");
      debugPrint(response.toString());

      response.fold(
          (l) => emit(UpdateProjectStatusErrorState(errorMessage: l.message)),
          (r) => emit(UpdateProjectStatusSuccessState(
              projectStatusUpdateMainResEntity: r)));
    });
    on<GetProjectDetailEvent>((event, emit) async {
      emit(ProjectDetailLoadingState());
      final response =
          await _projectDetailUseCase.call(event.projectDetailReqParams);
      debugPrint("GetProjectDetailEvent Response");
      debugPrint(response.toString());
      response.fold(
          (l) => emit(ProjectDetailErrorState(errorMessage: l.message)),
          (r) =>
              emit(ProjectDetailSuccessState(projectDetailMainResEntity: r)));
    });
  }
}
