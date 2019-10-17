import 'package:fl_chart/fl_chart.dart';

import '../models/weight_observation.dart';
//import '../weight_observations_JUNK_DATA.dart';

List<FlSpot> createDots(List<WeightObservation> weightObservations) {
  List<FlSpot> dotsList = [];
  double i = 0;
  weightObservations.forEach((observation) {
    dotsList.add(FlSpot(i, observation.value.toDouble()));
    i++;
  });
  return dotsList;
}

double getLowestObservationValue(List<WeightObservation> weightObservations) {
  const double _maxValue = 10000;
  double _lowestValue = _maxValue;
  weightObservations.forEach((observation) {
    if (observation.value < _lowestValue) {
      _lowestValue = observation.value;
    }
  });

  if (_lowestValue == _maxValue) {
    print("error in getLowestValue: no correct value given");
  }
  print("lowest value = $_lowestValue");
  return _lowestValue;
}

double getHighestObservationValue(List<WeightObservation> weightObservations) {
  const double _minValue = -10000;
  double _highestValue = _minValue;
  weightObservations.forEach((observation) {
    if (observation.value > _highestValue) {
      _highestValue = observation.value;
    }
  });

  if (_highestValue == _minValue) {
    print("error in getHighestValue: no correct value given");
  }
  print("highest value = $_highestValue");
  return _highestValue;
}

void getSpotPosition() {
  
}
