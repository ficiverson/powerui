abstract class ConsumptionDataAPIContract {
  String baseUrl = "";
  String params = "";
}

class ConsumptionDataAPI implements ConsumptionDataAPIContract {
  @override String baseUrl = "https://dummyjson.com/";
  @override String params = "products/1";
}

