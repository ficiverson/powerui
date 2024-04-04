import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:powerui/models/consumption.dart';

import '../../injector/dependency_injector.dart';
import 'home_presenter.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  MyHomePageState createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with WidgetsBindingObserver
    implements HomeView {
  late HomePresenter _presenter;
  late MediaQueryData queryData;
  late BuildContext context;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<FlSpot> points = [];

  MyHomePageState() {
    DependencyInjector().injectByView(this);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    queryData = MediaQuery.of(context);
    return Scaffold(
        key: scaffoldKey,
        body: _getBodyLayout());
  }

  @override
  void dispose() {
    Injector.appInstance.removeByKey<HomeView>();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void initState() {
    super.initState();

    _presenter = Injector.appInstance.get<HomePresenter>();
    _presenter.init();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onComsumptionDataerror(error) {
    // TODO: implement onComsumptionDataerror
  }

  @override
  void onLoadData(List<Consumption> data) {
    points = [];
    double index =0;
    setState(() {
      data.forEach((element) {
        print(element.value);
        index++;
        points.add( FlSpot(index, element.value));
      });
    });
  }



  // private methods

  Widget _getBodyLayout() {
    Widget content = Container();
    return  LineChart(LineChartData(
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      ),
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: 1,
            //getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom:
          BorderSide(color: Colors.white, width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      lineBarsData: [LineChartBarData(
        isCurved: true,
        color: Colors.green,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: points,
      )],
      minX: 0,
      maxX: 10,
      maxY: 256,
      minY: 0,
    ));
  }



}
