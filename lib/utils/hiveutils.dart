import 'package:hive/hive.dart';

Future<Box<T>?>? opedHive<T>(name) async {
  try {
    final cache = Hive.box<T>(name);

    if (!cache.isOpen) {
      return cache;
    } else {
      return await Hive.openBox(name);
    }
  } catch (e) {
    print("Erorr in $e");
    return await Hive.openBox(name);
  }
}
