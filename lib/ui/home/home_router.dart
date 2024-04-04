import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

abstract class HomeRouterContract {
  goToSecondScreen(String data);
}

class HomeRouter implements HomeRouterContract {
  @override
  goToSecondScreen(String data) {
   /*
   *
   *  Navigator.of(Injector.appInstance.get<BuildContext>()).push(
        MaterialPageRoute(
            settings: RouteSettings(name: "schedules"),
            builder: (BuildContext context) =>
                SecondScreem(timeTables: data),
            fullscreenDialog: false));
   *
   * */
  }

}
