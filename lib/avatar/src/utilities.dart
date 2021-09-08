import 'dart:math';

T pickRandomItem<T>(List<T> collection) {
  return collection[Random().nextInt(collection.length)];
}

T pickOneItem<T>(List<dynamic> collection, dynamic id) {
  var result = collection.where((element) => element.id == id);
  return result.elementAt(0);
}

String enumToJson<T>(T value) =>
    value != null ? value.toString().split('.')[1] : "";

T enumFromJson<T>(List<T> values, String json) => values
    .firstWhere((it) => enumToJson(it).toLowerCase() == json.toLowerCase());
