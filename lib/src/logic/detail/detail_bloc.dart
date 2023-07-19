import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(const DetailInitial(val: false, ind: null)) {
    on<ChangeReadmore>((event, emit) {
      emit(DetailInitial(val: event.value,ind: event.index));
    });
  }
}
