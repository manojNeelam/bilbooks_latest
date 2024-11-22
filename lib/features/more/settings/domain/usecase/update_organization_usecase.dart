import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/update_organization_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/repository/organization_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateOrganizationUsecase
    implements
        UseCase<UpdateOrganizationMainResEntity, UpdateOrganizationReqParams> {
  final OrganizationRepository organizationRepository;
  UpdateOrganizationUsecase({required this.organizationRepository});
  @override
  Future<Either<Failure, UpdateOrganizationMainResEntity>> call(params) {
    return organizationRepository.updateOrganizationDetails(params);
  }
}

class UpdateOrganizationReqParams {
  final String name,
      address,
      city,
      state,
      zipcode,
      country,
      timezone,
      registrationNo,
      phone,
      fax,
      website,
      fiscalYear,
      currency,
      language,
      primarycontactName,
      primarycontactEmail;

  UpdateOrganizationReqParams(
      {required this.website,
      required this.fiscalYear,
      required this.currency,
      required this.language,
      required this.primarycontactEmail,
      required this.primarycontactName,
      required this.registrationNo,
      required this.phone,
      required this.fax,
      required this.state,
      required this.zipcode,
      required this.country,
      required this.timezone,
      required this.name,
      required this.address,
      required this.city});
}

/*
action:
name:Marks Tech
address:asdf nnnmn
city:asdf
state:sadf
zipcode:6753
country:12
timezone:14
registration_no:5454
phone:8754541254
fax:FX55
website:website.com
fiscal_year:9
currency:7
language:2
primarycontact_name:Dhananjay Supe
primarycontact_email:dhananjaysupe@webwingz.com
*/