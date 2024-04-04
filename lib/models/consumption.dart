import 'dart:math';

class Consumption {
  late double value;

  Consumption.fromInstance(Map<String, dynamic> map)
      :
        value = map["title"]["value"];

  Consumption.mock()
      : value = Random().nextDouble() * 256;
}