import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home_page.dart';
import 'util/hive.handler.dart';
import 'util/main/palette.dart';
import 'util/main/size_config.dart';
import 'util/main/theme.dart';

late Box boxPersonnel;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  hiveInit();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: primaryColor),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (context, Orientation orientation) {
            SizeConfig.init(constraints, orientation);
            return MaterialApp(
              title: 'Plearn',
              debugShowCheckedModeBanner: false,
              theme: themeMain,
              locale: const Locale("en", "US"),
              supportedLocales: const [
                Locale("en", "US"),
                Locale("fa", "IR"),
              ],
              home: const HomePage(),
            );
          },
        );
      },
    );
  }
}
