import 'screen/manager/manager.screen.dart';
import 'screen/personnel/personnel.screen.dart';
import 'package:flutter/material.dart';
import 'util/main/size_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> screens = [
    const ManagerScreen(),
    const PersonnelScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig.init(constraints, orientation);
            return SafeArea(
              child: Scaffold(
                body: screens[currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: currentIndex,
                  onTap: (newIndex) {
                    setState(() {
                      currentIndex = newIndex;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                      label: 'Manager',
                      icon: Icon(Icons.sensor_occupied),
                    ),
                    BottomNavigationBarItem(
                      label: 'Personnel',
                      icon: Icon(Icons.groups),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
