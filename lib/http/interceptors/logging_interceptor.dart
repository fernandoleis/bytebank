import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('REQUEST');
    print('URL: ${data.baseUrl}');
    print('Headers: ${data.headers}');
    print('Body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // print(data.toString());
    print(
        '-----| | ------ || ------ || ------ || ------ || ------ || ------ || ------ || ------ || ------ || ------ || ------ || ------ || ------');
    print('RESPONSE');
    print('Headers: ${data.headers}');
    print('Status Code: ${data.statusCode}');
    print('Body: ${data.body}');
    return data;
  }
}

