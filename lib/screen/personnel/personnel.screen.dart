import '../../data/bloc/personnel/personnel_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/local/model/rating.model.dart';
import '../../util/rating.dart';
import '../../widget/button.material.main.dart';
import '../../widget/text_form_field.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import '../../data/local/model/personnel.model.dart';
import '../../util/main/snack.dart';

class PersonnelScreen extends StatefulWidget {
  const PersonnelScreen({Key? key}) : super(key: key);

  @override
  State<PersonnelScreen> createState() => _PersonnelScreenState();
}

class _PersonnelScreenState extends State<PersonnelScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<PersonnelModel> personnel = [];
  PersonnelModel person = PersonnelModel(
    name: '',
    cellphone: '',
    position: '',
    password: '',
  );
  final TextEditingController _tecCell = TextEditingController();
  final TextEditingController _tecPass = TextEditingController();
  final TextEditingController _tecName = TextEditingController();
  final TextEditingController _tecSurname = TextEditingController();
  final TextEditingController _tecPosition = TextEditingController();
  final GlobalKey<FormState> _keyValidation = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initHive();
  }

  initHive() {
    personnel = boxPersonnel.values.toList() as List<PersonnelModel>;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<PersonnelBloc>().add(LogoutEvent());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body:
          BlocBuilder<PersonnelBloc, PersonnelState>(builder: (context, state) {
        if (state is PersonnelInitial) {
          return loginView();
        } else if (state is PersonLoggedIn) {
          return mainView(state.person);
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }

  Widget mainView(PersonnelModel person) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(person.name),
            Text(person.surname ?? ''),
          ],
        ),
        const SizedBox(height: 12),
        if (person.email != null) ...[
          Text(person.email!),
          const SizedBox(height: 12),
        ],
        Text(person.cellphone),
        const SizedBox(height: 12),
        Text(person.position),
        const SizedBox(height: 12),
        if (person.rank != null) ...[
          Text(person.rank!),
          const SizedBox(height: 12),
        ],
        const Divider(height: 1, color: Colors.grey, thickness: 1),
        const SizedBox(height: 12),
        if (personnel.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: personnel.length,
            itemBuilder: (context, index) {
              var _ratingItem;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(personnel[index].name),
                    SizedBox(
                      // height: 100,
                      width: 120,
                      child: DropdownButtonFormField<RatingType>(
                        elevation: 2,
                        isDense: true,
                        alignment: Alignment.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          alignLabelWithHint: true,
                        ),
                        // value: _ratingItem,
                        value: person.ratings!.any(
                                (e) => e!.mobile == personnel[index].cellphone)
                            ? ratingItems.firstWhere(
                                (e2) =>
                                    e2.title ==
                                    person.ratings!.firstWhere(
                                      (e3) =>
                                          e3!.mobile ==
                                          personnel[index].cellphone,
                                    )!.title,
                              )
                            : _ratingItem,
                        // value: _ratingCalc[index],
                        hint: const Text('Select Rating'),
                        items: List.generate(
                          ratingItems.length,
                          (index) => DropdownMenuItem(
                            value: ratingItems[index],
                            child: Text(
                              ratingItems[index].title,
                            ),
                          ),
                        ),
                        onChanged: (item) {
                          context.read<PersonnelBloc>().add(
                                RateColleagueEvent(
                                  item!.title,
                                  personnel[index],
                                  person,
                                ),
                              );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget loginView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _keyValidation,
          child: Column(
            children: [
              const SizedBox(height: 12),
              textFormFieldWidget(
                'Cellphone Number',
                _tecCell,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cellphone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              textFormFieldWidget(
                'Password',
                _tecPass,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              textFormFieldWidget('Name', _tecName),
              const SizedBox(height: 12),
              textFormFieldWidget('Surname', _tecSurname),
              const SizedBox(height: 12),
              textFormFieldWidget('Position', _tecPosition),
              const SizedBox(height: 12),
              buttonMain(
                title: 'Login / Signup',
                action: () {
                  print(boxPersonnel.length);
                  print(personnel.length);
                  if (!_keyValidation.currentState!.validate()) {
                    showSnack(context, 'Fill all required information');
                  } else {
                    if (personnel
                        .any((element) => element.cellphone == _tecCell.text)) {
                      person = personnel.firstWhere(
                        (element) => element.cellphone == _tecCell.text,
                      );
                      if (person.password == _tecPass.text) {
                        context.read<PersonnelBloc>().add(LoginEvent(person));
                        clearTEC();
                        print("Ratings: ${person.ratings!.length}");
                      } else {
                        showSnack(context, 'Please enter correct password');
                      }
                    } else {
                      if (_tecName.text == '') {
                        showSnack(context, 'Please enter Name');
                      } else if (_tecPosition.text == '') {
                        showSnack(context, 'Please enter Position');
                      } else {
                        person = PersonnelModel(
                          name: _tecName.text,
                          surname: _tecSurname.text,
                          cellphone: _tecCell.text,
                          position: _tecPosition.text,
                          password: _tecPass.text,
                          ratings: [],
                        );
                        context
                            .read<PersonnelBloc>()
                            .add(RegisterEvent(person));
                        clearTEC();
                      }
                    }
                  }
                  initHive();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  clearTEC() {
    _tecCell.clear();
    _tecPass.clear();
    _tecName.clear();
    _tecSurname.clear();
    _tecPosition.clear();
  }
}
