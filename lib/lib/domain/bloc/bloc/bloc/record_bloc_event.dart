part of 'record_bloc_bloc.dart';

sealed class RecordBlocEvent extends Equatable {
  const RecordBlocEvent();

  @override
  List<Object> get props => [];
}


class Recorder extends RecordBlocEvent {}
