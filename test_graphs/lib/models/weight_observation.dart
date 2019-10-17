// this import permits to use @required
import 'package:flutter/foundation.dart';

class WeightObservation {
  int id;
  double value;
  DateTime datetime;

  WeightObservation({
    @required this.id,
    @required this.value,
    @required this.datetime,
  });
}

