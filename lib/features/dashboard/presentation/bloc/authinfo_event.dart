part of 'authinfo_bloc.dart';

@immutable
sealed class AuthinfoEvent {}

class GetAuthInfoEvent extends AuthinfoEvent {
  final AuthInfoReqParams params;
  GetAuthInfoEvent({required this.params});
}
