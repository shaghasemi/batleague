import 'package:batleague/widget/button.material.main.dart';
import 'package:batleague/widget/text_form_field.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import '../../data/local/model/personnel.model.dart';

class PersonnelScreen extends StatefulWidget {
  const PersonnelScreen({Key? key}) : super(key: key);

  @override
  State<PersonnelScreen> createState() => _PersonnelScreenState();
}

class _PersonnelScreenState extends State<PersonnelScreen> {
  List<PersonnelModel> personnel = [];
  bool isLoggedIn = false;
  final TextEditingController _tecCell = TextEditingController();
  final TextEditingController _tecPass = TextEditingController();

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
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Name'),
            const Text('Surname'),
          ],
        ),
        const Text('email'),
        const Text('cellphone'),
        const Text('position'),
        const Text('rank'),
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
    return Column(
      children: [
        textFormFieldWidget('Cellphone Number', _tecCell),
        textFormFieldWidget('Password', _tecPass),
        buttonMain(
          title: 'Login',
          action: () {
            setState(() {
              isLoggedIn = true;
            });
          },
        ),
      ],
    );
  }
}
