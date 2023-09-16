import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class HiveRepository {
  HiveRepository();

  static openHives(List<String> boxNames) async {
    var boxHives = boxNames.map((name) => Hive.openBox(name));
    debugPrint("trying to open hive boxes");
    await Future.wait(boxHives);
    debugPrint("Hive boxes opened");
  }

  add<T>({required T item, required String key, required String name}) {
    var box = Hive.box(name);
    checkBoxState(box);
    box.put(key, item);
  }

  T get<T>({required String key, required String name}) {
    var box = Hive.box(name);
    checkBoxState(box);
    return box.get(key);
  }

  remove<T>({required String key, required String name}) {
    var box = Hive.box(name);
    checkBoxState(box);
    return box.delete(key);
  }

  checkBoxState(box) {
    if (box == null) throw Exception('Box has not been set');
  }

  clear<T>({required String name}) async {
    var box = Hive.box(name);
    checkBoxState(box);
    await box.clear();
  }
}
