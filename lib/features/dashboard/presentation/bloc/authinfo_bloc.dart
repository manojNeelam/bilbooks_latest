import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/auth_info_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authinfo_event.dart';
part 'authinfo_state.dart';

class AuthinfoBloc extends Bloc<AuthinfoEvent, AuthinfoState> {
  final AuthInfoUsecase _authInfoUsecase;

  AuthinfoBloc({required AuthInfoUsecase authInfoUsecase})
      : _authInfoUsecase = authInfoUsecase,
        super(AuthinfoInitial()) {
    on<GetAuthInfoEvent>((event, emit) async {
      emit(AuthInfoLoadingState());
      final response = await _authInfoUsecase.call(event.params);
      response.fold((l) => emit(AuthInfoErrorState(errorMessage: l.message)),
          (r) => emit(AuthInfoSuccessState(authInfoMainResEntity: r)));
    });
  }
}
