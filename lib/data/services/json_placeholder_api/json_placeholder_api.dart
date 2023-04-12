import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@singleton
class JsonPlaceholderApi {
  final http.Client client = http.Client();
  Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8',
  };

}