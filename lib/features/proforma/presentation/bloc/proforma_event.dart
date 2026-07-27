part of 'proforma_bloc.dart';

@immutable
sealed class ProformaEvent {}

class GetProformaListEvent extends ProformaEvent {
  final ProformaListReqParams params;
  GetProformaListEvent({required this.params});
}

class GetProformaDetailsEvent extends ProformaEvent {
  final ProformaDetailsReqParams params;
  GetProformaDetailsEvent({required this.params});
}
