import '../../models/consumption.dart';
import '../result/result.dart';

abstract class ConsumptionDataRepositoryContract {
  Future<Result<List<Consumption>>> getData();
}