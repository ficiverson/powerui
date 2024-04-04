import 'package:powerui/domain/repository/consumption_data_repository_contract.dart';

import '../../models/consumption.dart';
import '../invoker/base_use_case.dart';
import '../result/result.dart';

class GetDataUseCase extends BaseUseCase<DataPolicy, List<Consumption>> {
  ConsumptionDataRepositoryContract dataRepository;

  GetDataUseCase({required this.dataRepository});

  @override
  void invoke() {
    notifyListeners(dataRepository.getData());
  }
}