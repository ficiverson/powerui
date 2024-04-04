
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:powerui/utils/my_http_client.dart';
import '../data/consumption_data_repository.dart';
import '../data/datasource/consumption_data_remote_datasource.dart';
import '../domain/invoker/invoker.dart';
import '../domain/repository/consumption_data_repository_contract.dart';
import '../domain/usecase/get_all_data_use_case.dart';
import '../remote-data-source/consumoption/consumption_remote_datasource.dart';
import '../remote-data-source/network/consumption_data_api.dart';
import '../ui/home/home_presenter.dart';
import '../ui/home/home_router.dart';
import '../ui/home/home_view.dart';
import '../utils/connection_contract.dart';

enum Flavor { MOCK, PROD, STAGE }

class DependencyInjector {
  get injector {
    return Injector.appInstance;
  }

  loadModules() {
    loadPresentationModules();
    loadDomainModules();
    loadDataModules();
    loadRemoteDatasourceModules();
  }

  injectByView(dynamic view) {
   if (view is MyHomePageState) {
      Injector.appInstance
          .registerSingleton<BuildContext>(() => view.context, override: true);
      injector.registerDependency<HomeView>(() => view);
   }
  }

  loadPresentationModules() {
    injector.registerDependency<ConnectionContract>(() {
      return Connection();
    });

    injector.registerSingleton<Invoker>(() {
      return Invoker();
    });


    injector.registerDependency<HomeRouterContract>(() {
      return HomeRouter();
    });


    injector.registerDependency<HomePresenter>(() {
      return HomePresenter(injector.get<HomeView>(),
          invoker: injector.get<Invoker>(),
          router: injector.get<HomeRouterContract>(),
          getDataUseCase: injector.get<GetDataUseCase>());
    });

  }

  loadDomainModules() {

    injector.registerDependency<GetDataUseCase>(() {
      var dataRepository = injector.get<ConsumptionDataRepositoryContract>();
      return GetDataUseCase(dataRepository: dataRepository);
    });

  }

  loadDataModules() {
    injector.registerDependency<ConsumptionDataRepositoryContract>(() {
      var remoteDataSource = injector.get<ConsumptionDataRemoteDataSourceContract>();
      return ConsumptionDataRepository(remoteDataSource: remoteDataSource);
    });
  }

  loadRemoteDatasourceModules() {
    injector.registerDependency<MyHttpClient>(() => MyHttpClient(), override: true);
    injector.registerDependency<ConsumptionDataAPIContract>(() => ConsumptionDataAPI());
    injector.registerDependency<ConsumptionDataRemoteDataSourceContract>(() {
      return ConsumptionDataRemoteDataSource();
    });
  }
}
