import 'package:flutter/material.dart';
import 'util/main/size_config.dart';
import 'widget/button.material.main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig.init(constraints, orientation);
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                  )
                ]),
              ),
            );
          },
        );
      },
    );
  }

  Widget gameItem(
    BuildContext context,
    String title,
    Widget screen1,
    Widget screen2,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buttonMain(
          title: title,
          action: () => screenLoader(context, () => screen1),
        ),
        IconButton(
          iconSize: 32,
          color: Colors.red,
          onPressed: () => screenLoader(context, () => screen2),
          icon: const Icon(Icons.dashboard_customize),
        ),
      ],
    );
  }

  screenLoader(BuildContext context, Widget Function() builder) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => builder(),
      ),
    );
  }
}
