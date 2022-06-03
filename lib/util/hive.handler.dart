import 'package:hive_flutter/hive_flutter.dart';
import '../data/local/model/personnel.model.dart';
import '../main.dart';

String backupPath = '/storage/emulated/0/download/';

hiveInit() async {
  await Hive.initFlutter();
  hiveRegister();
  await hiveOpen();
}

hiveRegister() {
  Hive.registerAdapter(PersonnelModelAdapter());
}

hiveOpen() async {
  boxPersonnel = await Hive.openBox<PersonnelModel>('personnel');
}

hiveClose() {
  boxPersonnel.close();
}
