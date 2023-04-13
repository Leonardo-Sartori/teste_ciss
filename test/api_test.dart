import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Teste de chamada de API', () async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    expect(response.statusCode, 200);

    final data = jsonDecode(response.body);
    expect(data['userId'], 1);
    expect(data['id'], 1);
    expect(data['title'], 'sunt aut facere repellat provident occaecati excepturi optio reprehenderit');
    expect(data['body'], 'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto');
  });
}
