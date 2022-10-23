// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingToggleBloc extends Cubit<LandingToggleModelForBloc> {
  LandingToggleBloc() : super(LandingToggleModelForBloc(position: 0));

  void increment() => emit(state);
}

class LandingToggleModelForBloc {
  int? position;

  LandingToggleModelForBloc({this.position});
}
