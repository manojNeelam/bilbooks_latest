import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/core/api/api_endpoint_urls.dart';
import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../domain/usecase/project_usecase.dart';
import '../models/add_project_response_data_model.dart';
import '../models/project_delete_data_model.dart';
import '../models/project_detail_response_data_model.dart';
import '../models/project_list_data.dart';
import '../models/project_update_status_data_model.dart';

abstract interface class ProjectDatasource {
  Future<ProjectMainResModel> getProjectList(ProjectListParams params);
  Future<AddProjectMainResponseDataModel> addProject(AddProjectParams params);
  Future<ProjectDeleteMainDataModel> deleteProject(DeleteProjectParams params);
  Future<ProjectStatusUpdateMainDataModel> updateStatus(
      UpdateProjectStatusParams params);
  Future<ProjectDetailMainResDataModel> getProjectDetails(
      ProjectDetailReqParams params);
}

class ProjectDatasourceImpl implements ProjectDatasource {
  final APIClient apiClient;
  ProjectDatasourceImpl({required this.apiClient});
  @override
  Future<ProjectMainResModel> getProjectList(ProjectListParams params) async {
    try {
      /*
      //page:
//per_page:
//totalrecords:
q:
//client:
//sort_column:
//sort_order:
status:active
      */
      Map<String, dynamic> queryParameters = {
        "status": params.status,
        "q": params.query,
        "sort_column": params.sortColumn,
        "page": params.page,
        //"sort_order": params.sortOder
      };
      debugPrint(queryParameters.toString());
      if (params.clientId != null) {
        queryParameters.addAll({"client": params.clientId ?? ""});
      }
      final response = await apiClient.getRequest(ApiEndPoints.projects,
          queryParameters: queryParameters);
      if (response.statusCode == 200) {
        final resModel = ProjectMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<AddProjectMainResponseDataModel> addProject(
      AddProjectParams params) async {
    try {
      Map<String, String> body = {
        "name": params.name,
        "client": params.client,
        "description": params.description,
        "status": params.status
      };
      if (params.id != null) {
        body.addAll({"id": params.id!});
      }
      final reqPrams = FormData.fromMap(body);

      final response = await apiClient.postRequest(
          path: ApiEndPoints.addProjects, body: reqPrams);
      if (response.statusCode == 200) {
        final resModel =
            AddProjectMainResponseDataModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid Status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<ProjectDeleteMainDataModel> deleteProject(
      DeleteProjectParams params) async {
    try {
      Map<String, String> reqPrams = {
        "id": params.id,
      };
      final response = await apiClient.deleteRequest(
          path: ApiEndPoints.deleteProject, queryParameters: reqPrams);
      if (response.statusCode == 200) {
        final resModel = ProjectDeleteMainDataModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid Status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<ProjectStatusUpdateMainDataModel> updateStatus(
      UpdateProjectStatusParams params) async {
    try {
      Map<String, String> body = {"id": params.id};
      final reqPrams = FormData.fromMap(body);

      final path = params.isActive
          ? ApiEndPoints.projectMakeInActive
          : ApiEndPoints.projectMakeActive;

      final response = await apiClient.postRequest(path: path, body: reqPrams);
      if (response.statusCode == 200) {
        final resModel =
            ProjectStatusUpdateMainDataModel.fromJson(response.data);
        debugPrint("ProjectStatusUpdateMainDataModel resModel: $resModel");
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid Status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<ProjectDetailMainResDataModel> getProjectDetails(
      ProjectDetailReqParams params) async {
    try {
      Map<String, String> body = {"id": params.id};
      final response = await apiClient.getRequest(ApiEndPoints.projectDetails,
          queryParameters: body);
      if (response.statusCode == 200) {
        final resModel = ProjectDetailMainResDataModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid Status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
