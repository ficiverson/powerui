import 'dart:async';
import 'package:powerui/utils/simple_client.dart';

class MyHttpClient extends SimpleClient {
  @override
  Future sendRequest (SimpleRequest request, HTTPResponseType responseType) {
    return super.sendRequest(request,responseType);
  }

}
