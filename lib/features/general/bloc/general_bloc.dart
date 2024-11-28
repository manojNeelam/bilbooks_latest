import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'general_event.dart';
part 'general_state.dart';

class GeneralBloc extends Bloc<GeneralEvent, GeneralState> {
  GeneralBloc() : super(GeneralInitial()) {
    on<SetEstimateHeading>((event, emit) {
      debugPrint("SetEstimateHeading Event");
      emit(EstimateHeadingState(estimateHeading: event.estimateHeading));
    });
  }
}
