import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/bloc/personnel/personnel_bloc.dart';
import '../../main.dart';
import '../../util/rating.dart';
import 'package:flutter/material.dart';
import '../../data/local/model/personnel.model.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({Key? key}) : super(key: key);

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen>
    with AutomaticKeepAliveClientMixin {
  List<PersonnelModel> personnel = [];
  late List<List<int>> sumMatrix2;

  @override
  void initState() {
    super.initState();
    initHive();
    setState(() {});
    initSums();
  }

  initHive() {
    personnel = boxPersonnel.values.toList() as List<PersonnelModel>;
  }

  initSums() {
    sumMatrix2 = List.generate(
      personnel.length,
      (index) => List.generate(ratingItems.length, (index) => 0),
    );
  }

  calculateRatings2() {
    initHive();
    initSums();
    for (int i = 0; i < personnel.length; i++) {
      for (var e1 in personnel[i].ratings!) {
        sumMatrix2[personnel.indexWhere((e2) => e2.email == e1!.email)]
            [ratingItems.indexWhere((e3) => e3.title == e1!.title)]++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonnelBloc, PersonnelState>(
        builder: (context, state) {
      calculateRatings2();
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Manager',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: personnel.length, //TODO: Change to bloc
              itemBuilder: (context, index1) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              personnel[index1].email,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: ratingItems.length,
                            itemBuilder: (context, index2) => SizedBox(
                              width: 100,
                              height: 50,
                              child: Center(
                                child: Text(
                                  '${ratingItems[index2].title}: ${sumMatrix2[index1][index2]}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
