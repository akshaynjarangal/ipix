part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class ChangeReadmore extends DetailEvent{
  final bool value;
  final int index;
  const ChangeReadmore({required this.index,required this.value});
}