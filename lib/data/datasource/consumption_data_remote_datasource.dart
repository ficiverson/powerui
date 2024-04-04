

import 'package:powerui/models/consumption.dart';

abstract class ConsumptionDataRemoteDataSourceContract {
  Future<List<Consumption>> getAllConsumptionData();
}