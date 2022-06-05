import '../../local/model/personnel.model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../main.dart';
import '../../local/model/rating.model.dart';

part 'personnel_event.dart';

part 'personnel_state.dart';

class PersonnelBloc extends Bloc<PersonnelEvent, PersonnelState> {
  PersonnelBloc() : super(PersonnelInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(PersonnelInitial());
      List<PersonnelModel> personnel =
          boxPersonnel.values.toList() as List<PersonnelModel>;
      if (!personnel.any((e) => e.email == event.person.email)) {
        event.person.ratings ??= [];
        boxPersonnel.add(event.person);
      }
      emit(PersonLoggedIn(person: event.person));
    });

    on<RegisterEvent>((event, emit) async {
      boxPersonnel.add(event.person);
      emit(PersonLoggedIn(person: event.person));
    });

    on<LogoutEvent>((event, emit) async {
      emit(PersonnelInitial());
    });

    on<RateColleagueEvent>(
      (event, emit) async {
        emit(PersonnelInitial());
        if (event.person.ratings!.any(
          (e) => e!.email == event.colleague.email,
        )) {
          event.person.ratings!
              .firstWhere(
                (e) => e!.email == event.colleague.email,
              )!
              .title = event.ratingTitle;
        } else {
          event.person.ratings!.add(
            Rating(
              event.colleague.email,
              event.ratingTitle,
            ),
          );
        }
        boxPersonnel.putAt(
          boxPersonnel.values.toList().indexOf(event.person),
          event.person,
        );
        emit(PersonLoggedIn(person: event.person));
      },
    );
  }
}
