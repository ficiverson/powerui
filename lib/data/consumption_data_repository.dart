import 'dart:async';


import 'package:powerui/domain/repository/consumption_data_repository_contract.dart';
import 'package:powerui/models/consumption.dart';

import '../domain/result/result.dart';
import 'datasource/consumption_data_remote_datasource.dart';

class ConsumptionDataRepository implements ConsumptionDataRepositoryContract {
  ConsumptionDataRemoteDataSourceContract remoteDataSource;
  ConsumptionDataRepository({required this.remoteDataSource});

  @override
  Future<Result<List<Consumption>>> getData() async {
    List<Consumption> consumptionData = await remoteDataSource.getAllConsumptionData();
    return Success(consumptionData, Status.ok);
  }

}
