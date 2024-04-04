import 'dart:async';

import 'package:injector/injector.dart';
import 'package:powerui/domain/usecase/get_all_data_use_case.dart';
import '../../domain/invoker/invoker.dart';
import '../../domain/result/result.dart';
import '../../models/consumption.dart';
import '../../utils/connection_contract.dart';
import 'home_router.dart';

abstract class HomeView {
  void onLoadData(List<Consumption> data);
  void onComsumptionDataerror(dynamic error);
}

enum StatusPlayer { PLAYING, FAILED, STOP }

class HomePresenter {
  HomeView _homeView;
  Invoker invoker;
  GetDataUseCase getDataUseCase;
  HomeRouterContract router;
  late ConnectionContract connection;
  bool isLoading = false;

  HomePresenter(this._homeView,
      {required this.invoker,
      required this.router,
      required this.getDataUseCase}) {

    connection = Injector.appInstance.get<ConnectionContract>();
  }

  init() async {
    _loadData();
  }

  //private methods
  _loadData(){
    invoker.execute(getDataUseCase).listen((result) {
      if (result is Success) {
        _homeView.onLoadData(result.data);
      } else {
        _homeView.onComsumptionDataerror((result as Error).status);
      }
    });
  }
}
