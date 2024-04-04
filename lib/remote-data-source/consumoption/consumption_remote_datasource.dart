import 'dart:async';

import 'package:injector/injector.dart';
import 'package:powerui/data/datasource/consumption_data_remote_datasource.dart';
import 'package:powerui/models/consumption.dart';
import 'package:powerui/remote-data-source/network/consumption_data_api.dart';
import 'package:powerui/utils/my_http_client.dart';
import 'package:powerui/utils/simple_client.dart';

class ConsumptionDataRemoteDataSource implements ConsumptionDataRemoteDataSourceContract {
  final MyHttpClient client = Injector.appInstance.get<MyHttpClient>();
  ConsumptionDataAPIContract dataAPI = Injector.appInstance.get<ConsumptionDataAPIContract>();

  @override
  Future<List<Consumption>> getAllConsumptionData() async {
    Uri url = Uri.parse("${dataAPI.baseUrl}${dataAPI.params}");
    try {
      var res = await client.get(url);
      return [Consumption.mock(),Consumption.mock(),Consumption.mock(),Consumption.mock(),Consumption.mock(),Consumption.mock(),Consumption.mock(),Consumption.mock(),Consumption.mock(),Consumption.mock()];
    } catch (exception) {
      return [];
    }
  }
}
