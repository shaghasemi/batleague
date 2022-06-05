import 'package:firebase_auth/firebase_auth.dart';
import '../../data/bloc/personnel/personnel_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    email: '',
    position: '',
    password: '',
  );
  final TextEditingController _tecEmail = TextEditingController();
  final TextEditingController _tecPass = TextEditingController();
  final TextEditingController _tecName = TextEditingController();
  final TextEditingController _tecSurname = TextEditingController();
  final TextEditingController _tecPosition = TextEditingController();
  final GlobalKey<FormState> _keyValidation = GlobalKey<FormState>();
  bool showLogin = true;

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
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () async {
                  context.read<PersonnelBloc>().add(LogoutEvent());
                  await FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: BlocBuilder<PersonnelBloc, PersonnelState>(
            builder: (context, state) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (userSnapshot.hasData && state is PersonLoggedIn) {
                return mainView(state.person);
              }
              return showLogin ? loginView() : registerView();
            },
          ),
        );
      },
    );
  }

  Widget mainView(PersonnelModel person) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(person.email),
        const SizedBox(height: 12),
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
                    Text(personnel[index].email),
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
                        value: person.ratings!
                                .any((e) => e!.email == personnel[index].email)
                            ? ratingItems.firstWhere((e2) =>
                                e2.title ==
                                person.ratings!
                                    .firstWhere((e3) =>
                                        e3!.email == personnel[index].email)!
                                    .title)
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

  Widget registerView() {
    final _auth = FirebaseAuth.instance;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _keyValidation,
          child: Column(
            children: [
              const SizedBox(height: 12),
              textFormFieldWidget(
                'Email',
                _tecEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email address';
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
              buttonMain(
                title: 'Register',
                action: () async {
                  UserCredential userCredential;
                  if (!_keyValidation.currentState!.validate()) {
                    showSnack(context, 'Fill all required information');
                  } else {
                    userCredential = await _auth.createUserWithEmailAndPassword(
                      email: _tecEmail.text.trim(),
                      password: _tecPass.text,
                    );
                    person = PersonnelModel(
                      email: _tecEmail.text.trim(),
                      password: _tecPass.text,
                      ratings: [],
                    );
                    context.read<PersonnelBloc>().add(RegisterEvent(person));
                    clearTEC();
                  }
                  initHive();
                },
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  setState(() {
                    showLogin = true;
                  });
                },
                child: const Text('Go To Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginView() {
    final _auth = FirebaseAuth.instance;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _keyValidation,
          child: Column(
            children: [
              const SizedBox(height: 12),
              textFormFieldWidget(
                'Email',
                _tecEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email address';
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
              buttonMain(
                title: 'Login',
                action: () async {
                  UserCredential userCredential;
                  if (!_keyValidation.currentState!.validate()) {
                    showSnack(context, 'Fill all required information');
                  } else {
                    userCredential = await _auth.signInWithEmailAndPassword(
                      email: _tecEmail.text.trim(),
                      password: _tecPass.text,
                    );
                      person = PersonnelModel(
                        email: _tecEmail.text.trim(),
                        password: _tecPass.text,
                        ratings: [],
                      );
                    context.read<PersonnelBloc>().add(LoginEvent(person));
                    clearTEC();
                    clearTEC();
                  }
                  initHive();
                },
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  setState(() {
                    showLogin = false;
                  });
                },
                child: const Text('Register New User'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  clearTEC() {
    _tecEmail.clear();
    _tecPass.clear();
    _tecName.clear();
    _tecSurname.clear();
    _tecPosition.clear();
  }
}
