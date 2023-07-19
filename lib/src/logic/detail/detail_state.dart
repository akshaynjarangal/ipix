part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState(
    {required this.isReadmore,
     this.index
    }
  );
  final bool isReadmore;
  final int? index;
  @override
  List<Object?> get props => [isReadmore,index];
}

class DetailInitial extends DetailState {
  final bool val;
  final int? ind;
  const DetailInitial({required this.val,this.ind}):super(isReadmore: val,index: ind);
}
