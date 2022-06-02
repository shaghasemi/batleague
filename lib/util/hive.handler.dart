import 'package:hive_flutter/hive_flutter.dart';
import '../main.dart';

String backupPath = '/storage/emulated/0/download/';

hiveInit() async {
  await Hive.initFlutter();
  hiveRegister();
  hiveOpen();
}

hiveRegister() {
  Hive.registerAdapter(DragColorCardModelAdapter());
}

hiveOpen() async {
  boxPersonnel =
      await Hive.openBox<DragColorCardModel>('personnel');
}

hiveClose() {
  boxPersonnel.close();
}