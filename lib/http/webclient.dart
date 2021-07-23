import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
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

Future<List<Transaction>> findAll() async {
  Client client = InterceptedClient.build(interceptors: [
    LoggingInterceptor(),
  ]);
  final Response response = await client.get(Uri.parse('http://192.168.0.13:8080/transactions')).timeout(Duration(seconds: 5));
  final List<Transaction> transactions = [];
  final List<dynamic> decodedJson = jsonDecode(response.body);
  for (Map<String, dynamic> transactionJson in decodedJson) {
    Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(
      transactionJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}
