import '../../main.dart';
import '../../util/rating.dart';
import 'package:flutter/material.dart';
import '../../data/local/model/personnel.model.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({Key? key}) : super(key: key);

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  List<PersonnelModel> personnel = [];

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
            itemBuilder: (context, index) {
              List<int> count = List.generate(ratingItems.length, (index) => 0);
              personnel[index].ratings!.forEach((e) {
                switch (e!.title) {
                  case 'Batman':
                    count[0]++;
                    break;
                  case 'Superman':
                    count[1]++;
                    break;
                  case 'Hulk':
                    count[2]++;
                    break;
                  case 'Robin':
                    count[3]++;
                    break;
                  default:
                }
              });
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                            personnel[index].name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(personnel[index].position),
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
                          itemBuilder: (context, index) => SizedBox(
                            width: 100,
                            height: 50,
                            child: Center(
                              child: Text(
                                '${ratingItems[index].title}: ${count[index]}',
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
  }
}
