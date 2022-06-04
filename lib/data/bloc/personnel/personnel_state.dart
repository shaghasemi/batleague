part of 'personnel_bloc.dart';

@immutable
abstract class PersonnelState extends Equatable {
  const PersonnelState();

  @override
  List<Object> get props => [];
}

class PersonnelInitial extends PersonnelState {}

class PersonLoggedIn extends PersonnelState {
  final PersonnelModel person;

  const PersonLoggedIn({required this.person});

  @override
  List<Object> get props => [person];
}
