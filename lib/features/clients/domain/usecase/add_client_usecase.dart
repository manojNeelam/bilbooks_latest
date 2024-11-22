import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../../presentation/Models/client_person_model.dart';
import '../entities/add_client_entity.dart';
import '../repository/client_repository.dart';

class AddClientUsecase
    implements UseCase<ClientAddMainResEntity, AddClientUsecaseReqParams> {
  final ClientRepository clientRepository;
  AddClientUsecase({required this.clientRepository});

  @override
  Future<Either<Failure, ClientAddMainResEntity>> call(
      AddClientUsecaseReqParams params) {
    return clientRepository.addClient(params);
  }
}

class AddClientUsecaseReqParams {
  final String id;
  final String address, name;
  final String city,
      state,
      zipCode,
      phone,
      countryId,
      registrationNo,
      website,
      currency,
      paymentTerms,
      language,
      shippingAddress,
      shippingCity,
      shippingState;
  final String shippingZipcode,
      shippingPhone,
      shippingCountry,
      remarks,
      contactName,
      contactEmail,
      contactPhone,
      contactId;
  final List<ClientPersonModel> clientPersons;

  AddClientUsecaseReqParams({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phone,
    required this.countryId,
    required this.registrationNo,
    required this.website,
    required this.currency,
    required this.paymentTerms,
    required this.language,
    required this.shippingAddress,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingZipcode,
    required this.shippingPhone,
    required this.shippingCountry,
    required this.remarks,
    required this.contactName,
    required this.contactEmail,
    required this.contactPhone,
    required this.clientPersons,
    required this.contactId,
  });
}

/*
//id:23532
//contact_id:30238
persons:[{"name":"krunal","email":"primaryp@gmail.com","phone":"987654"}]
//persons[0]:{↵	"name": "Ram",↵	"email": "p1.example.com",↵	"phone": "5555656565"↵}
//persons[1]:{↵	"name": "Ram",↵	"email": "p1.example.com",↵	"phone": "5555656565"↵}
//persons[2]:{↵	"name": "Ram",↵	"email": "p1.example.com",↵	"phone": "5555656565"↵}
address:test address
city:test city
state:test state
zipcode:test zipcode
phone:test phone
country_id:111
registration_no:1643
website:test website
currency:INR
payment_terms:0
language:en
enable_portal:0
shipping_address:test shipping add
shipping_city:test shipping city
shipping_state:test shipping state
shipping_zipcode:test shipping zipcode
shipping_phone:test shipping phone
shipping_country:111
remarks:test remarks
contact_name:Pname primary
contact_email:primaryP@gmail.com
contact_phone:5252524545
//registration_no:
*/
