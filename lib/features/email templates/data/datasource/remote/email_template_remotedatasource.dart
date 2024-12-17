import 'package:billbooks_app/features/email%20templates/data/model/email_template_model.dart';
import 'package:billbooks_app/features/email%20templates/data/model/update_email_template_model.dart';
import 'package:billbooks_app/features/email%20templates/domain/usecase/email_template_usecase.dart';
import 'package:billbooks_app/features/email%20templates/presentation/email_template_page.dart';
import 'package:billbooks_app/features/email%20templates/presentation/update_email_template_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_endpoint_urls.dart';
import '../../../../../core/api/api_exception.dart';

abstract interface class EmailTemplateRemotedatasource {
  Future<EmailTemplateMainResponseModel> getEmaillTemplates(
      EmailTemplateReqParams params);
  Future<UpdateEmailTemplateMainResponseModel> updateEmailTemplate(
      UpdateEmailTemplateReqParams params);
}

class EmailTemplateRemotedatasourceImpl
    implements EmailTemplateRemotedatasource {
  final APIClient apiClient;
  EmailTemplateRemotedatasourceImpl({required this.apiClient});

  @override
  Future<EmailTemplateMainResponseModel> getEmaillTemplates(
      EmailTemplateReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = {};

      final response = await apiClient.getRequest(ApiEndPoints.emailTemplates,
          queryParameters: queryParameters);
      debugPrint("EmailTemplateMainResponseModel ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = emailTemplateMainResponseModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(message: "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());

      debugPrint("AccountsReceivablesMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<UpdateEmailTemplateMainResponseModel> updateEmailTemplate(
      UpdateEmailTemplateReqParams params) async {
    try {
      /*
      emailtemplate:sendinvoice
email_subject_sendinvoice:HI
email_message_sendinvoice:hello
email_subject_sendestimate:
email_message_sendestimate:
email_subject_paymentreminder:
email_message_paymentreminder:
email_subject_paymentthankyou:
email_message_paymentthankyou:
      */
      //params.type.titleandDesc;
      final subject = params.subject ?? "";
      final message = params.message ?? "";

      Map<String, dynamic> reqPrams = {
        "emailtemplate": params.type.emailTemplate,
        "email_subject_sendinvoice": params.type.isSendInvoice ? subject : "",
        "email_message_sendinvoice": params.type.isSendInvoice ? message : "",
        "email_subject_sendestimate": params.type.isSendEstimate ? subject : "",
        "email_message_sendestimate": params.type.isSendEstimate ? message : "",
        "email_subject_paymentreminder":
            params.type.isPaymentReminder ? subject : "",
        "email_message_paymentreminder":
            params.type.isPaymentReminder ? message : "",
        "email_subject_paymentthankyou":
            params.type.isPaymentThankyou ? subject : "",
        "email_message_paymentthankyou":
            params.type.isPaymentThankyou ? message : "",
      };
      final body = FormData.fromMap(reqPrams);
      const path = ApiEndPoints.updateEmailTemplates;
      final response = await apiClient.postRequest(
        path: path,
        body: body,
      );
      // final response = await apiClient.getRequest(ApiEndPoints.emailTemplates,
      //     queryParameters: queryParameters);
      debugPrint("UpdateEmailTemplateMainResponseModel ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel =
            updateEmailTemplateMainResponseModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(message: "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());

      debugPrint("UpdateEmailTemplateMainResponseModel error");
      throw ApiException(message: e.toString());
    }
  }
}
