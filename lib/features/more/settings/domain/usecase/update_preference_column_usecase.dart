// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/repository/organization_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/model/preference_update_model.dart';

class UpdatePreferenceColumnUsecase
    implements
        UseCase<PreferenceUpdateMainResModel, UpdatePreferenceColumnReqParams> {
  final OrganizationRepository organizationRepository;
  UpdatePreferenceColumnUsecase({required this.organizationRepository});

  @override
  Future<Either<Failure, PreferenceUpdateMainResModel>> call(
      UpdatePreferenceColumnReqParams params) {
    return organizationRepository.updateColumnSettings(params);
  }
}

class UpdatePreferenceColumnReqParams {
  final String columnItemsTitle;
  final String columnItemsOther;
  final String columnUnitsTitle;
  final String columnUnitsOther;
  final String columnRateTitle;
  final String columnRateOther;
  final String columnAmountTitle;
  final String columnAmountOther;
  final bool columnDate;
  final bool columnTime;
  final bool columnCustom;
  final String columnCustomTitle;
  final bool hideColumnQty;
  final bool hideColumnRate;
  final bool hideColumnAmount;
  UpdatePreferenceColumnReqParams({
    required this.columnItemsTitle,
    required this.columnItemsOther,
    required this.columnUnitsTitle,
    required this.columnUnitsOther,
    required this.columnRateTitle,
    required this.columnRateOther,
    required this.columnAmountTitle,
    required this.columnAmountOther,
    required this.columnDate,
    required this.columnTime,
    required this.columnCustom,
    required this.columnCustomTitle,
    required this.hideColumnQty,
    required this.hideColumnRate,
    required this.hideColumnAmount,
  });
}
