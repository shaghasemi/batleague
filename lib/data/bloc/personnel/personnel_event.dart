part of 'personnel_bloc.dart';

@immutable
abstract class PersonnelEvent extends Equatable {
  const PersonnelEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends PersonnelEvent {
  final PersonnelModel person;

  const LoginEvent(this.person);
}

class RegisterEvent extends PersonnelEvent {
  final PersonnelModel person;

  const RegisterEvent(this.person);
}

class LogoutEvent extends PersonnelEvent {}

class RateColleagueEvent extends PersonnelEvent {
  final String ratingTitle;
  final PersonnelModel colleague;
  final PersonnelModel person;

  const RateColleagueEvent(
    this.ratingTitle,
    this.colleague,
    this.person,
  );

  @override
  List<Object> get props => [];
}
