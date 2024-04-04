import 'package:powerui/domain/invoker/use_case_callback.dart';

import '../result/result.dart';

abstract class BaseUseCase<P,T>{
  P? params;
  UseCaseCallback callback = UseCaseCallback();
  void invoke();

  void notifyListeners(Future<Result<T>> task){
    callback.addTask(task);
  }

  BaseUseCase<P,T> withParams(P params) {
    this.params = params;
    return this;
  }
}

