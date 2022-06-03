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

class _PersonnelScreenState extends State<PersonnelScreen> {
  List<PersonnelModel> personnel = [];
  PersonnelModel person = PersonnelModel(
    name: '',
    cellphone: '',
    position: '',
    password: '',
  );
  bool isLoggedIn = false;
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
              setState(() {
                person = PersonnelModel(
                  name: '',
                  cellphone: '',
                  position: '',
                  password: '',
                );
                isLoggedIn = false;
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: isLoggedIn ? mainView() : loginView(),
    );
  }

  Widget mainView() {
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
            itemCount: boxPersonnel.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(personnel[index].name),
                ],
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
                title: 'Login',
                action: () {
                  print(boxPersonnel.length);
                  print(personnel
                      .any((element) => element.cellphone == _tecCell.text));
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
                        setState(() {
                          clearTEC();
                          isLoggedIn = true;
                        });
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
                        );
                        // personnel.add(person);
                        boxPersonnel.add(person);
                        setState(() {
                          clearTEC();
                          isLoggedIn = true;
                        });
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
